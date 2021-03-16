# frozen_string_literal: true

require "net/http"

module Service::Recommendable
  extend ActiveSupport::Concern

  @@filter_param_transformers = {
    geographical_availabilities: -> name { Country.convert_to_regions_add_country(name) },
    scientific_domains: -> ids { ids.map(&:to_i) + ids.map { |id| ScientificDomain.find(id).descendant_ids }.flatten },
    category_id: -> slug { Category.find_by(slug: slug).id },
    providers: -> ids { ids.map(&:to_i) },
    related_platforms: -> ids { ids.map(&:to_i) },
    target_users: -> ids { ids.map(&:to_i) }
  }

  included do
    before_action only: :index do
      @params = params
    end
  end

  def fetch_recommended
    # Set unique client id per device per system
    if cookies[:client_uid].nil?
      cookies.permanent[:client_uid] = (SecureRandom.random_number(9e5) + 1e5).to_i + Time.now.getutc.to_i
    end

    size = get_services_size_by(ab_test(:recommendation_panel))
    if Mp::Application.config.recommender_host.nil?
      return Recommender::SimpleRecommender.new.call size
    end

    get_recommended_services_by(get_service_search_state, size)
  end

  private
    def get_recommended_services_by(body, size)
      url = Mp::Application.config.recommender_host + "/recommendations"
      response = Unirest.post(url, { "Content-Type" => "application/json" }, body.to_json)
      response_body = response.body.transform_keys(&:to_sym)
      if response.blank? || response_body[:recommendations].blank?
        Raven.capture_message("Recommendation service, recommendation endpoint response error")
        return Recommender::SimpleRecommender.new.call(size)
      end

      Service.where(id: response_body[:recommendations].take(size))
      rescue
        Raven.capture_message("Recommendation service, recommendation endpoint response error")
        Recommender::SimpleRecommender.new.call(size)
    end

    def get_service_search_state
      service_search_state = {
        timestamp: Time.now.strftime("%Y-%m-%dT%H:%M:%S.%L%z"),
        unique_id: cookies[:client_uid].to_i,
        visit_id: cookies[:client_uid].to_i  + Time.now.getutc.to_i,
        page_id: "/service",
        panel_id: ab_test(:recommendation_panel),
        search_data: get_filters_by(@params),
        logged_user: false
      }

      unless current_user.nil?
        service_search_state[:user_id] = current_user.id
        service_search_state[:logged_user] = true
      end

      service_search_state
    end

    def get_services_size_by(ab_test_version)
      case ab_test_version
      when "v1"
        3
      when "v2"
        2
      else
        3
      end
    end

    def get_filters_by(params)
      filters = {}
      unless params.nil?
        params.each do |key, value|
          next if key == "controller" || key == "action" || value.blank?

          filter_name = key.sub "-filter", ""
          filters[filter_name] = value
          if @@filter_param_transformers.key? filter_name.to_sym
            filters[filter_name] = @@filter_param_transformers[filter_name.to_sym].call value
          end
        end
      end
      filters
    end
end
