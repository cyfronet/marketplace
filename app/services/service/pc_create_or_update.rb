# frozen_string_literal: true

require "mini_magick"

class Service::PcCreateOrUpdate
  class ConnectionError < StandardError
    def initialize(msg)
      super(msg)
    end
  end

  def initialize(eic_service,
                 eic_base_url,
                 is_active,
                 modified_at,
                 unirest: Unirest)
    @unirest = unirest
    @eic_base_url = eic_base_url
    @eid = eic_service["id"]
    @eic_service =  eic_service
    @is_active = is_active
    @modified_at = modified_at
  end

  def call
    service = map_service(@eic_service)
    mapped_service = Service.joins(:sources).find_by("service_sources.source_type": "eic",
                                                     "service_sources.eid": @eid)
    source_id = mapped_service.nil? ? nil : ServiceSource.find_by("service_id": mapped_service.id, "source_type": "eic")&.id

    is_newer_update = mapped_service&.synchronized_at.present? ? (@modified_at >= mapped_service.synchronized_at) : true

    if mapped_service.nil? && @is_active
      service = Service.new(service)
      save_logo(service, @eic_service["logo"])
      if service.valid?
        if Service::Create.new(service).call
          ServiceSource.create!(service_id: service.id, source_type: "eic", eid: @eid)
        end
      else
        service.status = "errored"
        service.save(validate: false)
        ServiceSource.create!(service_id: service.id, source_type: "eic", eid: @eid)

      end
      service
    elsif is_newer_update
      if mapped_service && !@is_active
        Service::Update.new(mapped_service, service).call
        Service::Draft.new(mapped_service).call
        mapped_service
      elsif !source_id.nil? && mapped_service.upstream_id == source_id
        save_logo(mapped_service, @eic_service["logo"])
        Service::Update.new(mapped_service, service).call
        mapped_service
      else
        mapped_service
      end
    else
      mapped_service
    end
  end

  private
    def map_service(data)
      main_contact = MainContact.new(map_contact(data["mainContact"])) if data["mainContact"] || nil
      providers = Array(data.dig("resourceProviders", "resourceProvider"))
      scientific_domains = data.dig("scientificDomains", "scientificDomain").is_a?(Array) ?
         data.dig("scientificDomains", "scientificDomain").map { |sd|  sd["scientificSubdomain"] } :
         data.dig("scientificDomains", "scientificDomain", "scientificSubdomain")
      categories = data.dig("categories", "category").is_a?(Array) ?
         data.dig("categories", "category").map { |c| c["subcategory"] } :
         data.dig("categories", "category", "subcategory")

      { name: data["name"],
        pid: @eid,
        description: ReverseMarkdown.convert(data["description"],
                                             unknown_tags: :bypass,
                                             github_flavored: false),
        tagline: data["tagline"].blank? ? "-" : data["tagline"],
        tag_list: Array(data.dig("tags", "tag")) || [],
        language_availability: Array(data.dig("languageAvailabilities", "languageAvailability")).
            map { |lang| lang.upcase } || ["EN"],
        geographical_availabilities: Array(data.dig("geographicalAvailabilities", "geographicalAvailability") || "WW"),
        resource_geographic_locations: Array(data.dig("resourceGeographicLocations", "resourceGeographicLocation")) || [],
        target_users: Array(map_target_users(data.dig("targetUsers", "targetUser"))) || [],
        order_type: map_order_type(data["orderType"]),
        order_url: data["order"] || "",
        main_contact: main_contact,
        public_contacts: Array.wrap(data.dig("publicContacts", "publicContact")).
            map { |c| PublicContact.new(map_contact(c)) } || [],
        privacy_policy_url: data["privacyPolicy"] || "",
        use_cases_url: Array(data.dig("useCases", "useCase") || []),
        multimedia: Array(data.dig("multimedia", "multimedia")) || [],
        terms_of_use_url: data["termsOfUse"] || "",
        access_policies_url: data["accessPolicy"],
        sla_url: data["serviceLevel"] || "",
        webpage_url: data["webpage"] || "",
        manual_url: data["userManual"] || "",
        helpdesk_url: data["helpdeskPage"] || "",
        helpdesk_email: data["helpdeskEmail"] || "",
        security_contact_email: data["securityContactEmail"] || "",
        training_information_url: data["trainingInformation"] || "",
        status_monitoring_url: data["statusMonitoring"] || "",
        maintenance_url: data["maintenance"] || "",
        payment_model_url: data["paymentModel"] || "",
        pricing_url: data["pricing"] || "",
        trl: Vocabulary::Trl.where(eid: data["trl"]),
        required_services: map_related_services(Array(data.dig("requiredResources", "requiredResource"))),
        related_services: map_related_services(Array(data.dig("relatedResources", "relatedResource"))),
        life_cycle_status: Vocabulary::LifeCycleStatus.where(eid: data["lifeCycleStatus"]),
        access_types: Vocabulary::AccessType.where(eid: Array(data.dig("accessTypes", "accessType"))),
        access_modes: Vocabulary::AccessMode.where(eid: Array(data.dig("accessModes", "accessMode"))),
        status: "unverified",
        funding_bodies: map_funding_bodies(data.dig("fundingBody", "fundingBody")),
        funding_programs: map_funding_programs(data.dig("fundingPrograms", "fundingProgram")),
        changelog: Array(data.dig("changeLog", "changeLog")),
        certifications: Array(data.dig("certifications", "certification")),
        standards: Array(data.dig("standards", "standard")),
        open_source_technologies: Array(data.dig("openSourceTechnologies", "openSourceTechnology")),
        grant_project_names: Array(data.dig("grantProjectNames", "grantProjectName")),
        resource_organisation: map_provider(data["resourceOrganisation"]),
        providers: providers.map { |p| map_provider(p) },
        related_platforms: Array(data.dig("relatedPlatforms", "relatedPlatform")) || [],
        pc_categories: map_pc_categories(categories) || [],
        scientific_domains: map_scientific_domains(scientific_domains),
        version: data["version"] || "",
        last_update: data["lastUpdate"].present? ? Time.at(data["lastUpdate"].to_i) : nil,
        synchronized_at: @modified_at
      }
    end

    def map_target_users(target_users)
      TargetUser.where(eid: target_users)
    end

    def map_provider(prov_eid)
      mapped_provider = Provider.joins(:sources).find_by("provider_sources.source_type": "eic",
                                                         "provider_sources.eid": prov_eid)
      if mapped_provider.nil?
        prov = @unirest.get("#{@eic_base_url}/provider/#{prov_eid}",
                            headers: { "Accept" => "application/json" })

        if prov.code != 200
          raise Service::PcCreateOrUpdate::ConnectionError
            .new("Cannot connect to: #{@eic_base_url}. Received status #{prov.code}")
        end

        provider  = Provider.find_or_create_by(name: prov.body["name"])
        ProviderSource.create!(provider_id: provider.id, source_type: "eic", eid: prov_eid)
        provider
      else
        mapped_provider
      end
    end

    def save_logo(service, image_url)
      logo = open(image_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
      logo_content_type = logo.content_type

      if logo_content_type == "image/svg+xml"
        img = MiniMagick::Image.read(logo, ".svg")
        img.format "png" do |convert|
          convert.args.unshift "800x800"
          convert.args.unshift "-resize"
          convert.args.unshift "1200"
          convert.args.unshift "-density"
          convert.args.unshift "none"
          convert.args.unshift "-background"
        end

        logo = StringIO.new
        logo.write(img.to_blob)
        logo.seek(0)
        logo_content_type = "image/png"
      end
      if !logo.blank? && logo_content_type.start_with?("image")
        service.logo.attach(io: logo, filename: @eid, content_type: logo_content_type)
      end
    rescue OpenURI::HTTPError => e
      Rails.logger.warn "[WARNING] Cannot attach logo. #{e.message}"
    end

    def map_pc_categories(categories)
      Vocabulary::PcCategory.where(eid: categories)
    end

    def map_scientific_domains(domains)
      ScientificDomain.where(eid: domains)
    end

    def map_contact(contact)
      contact&.transform_keys { |k| k.to_s.underscore } || nil
    end

    def map_related_services(services)
      Service.joins(:sources).where("service_sources.source_type": "eic",
                              "service_sources.eid": services)
    end

    def map_funding_bodies(funding_bodies)
      Vocabulary::FundingBody.where(eid: funding_bodies)
    end

    def map_funding_programs(funding_programs)
      Vocabulary::FundingProgram.where(eid: funding_programs)
    end

    def map_order_type(order_type)
      order_type.gsub("order_type-", "") unless order_type.blank?
    end
end
