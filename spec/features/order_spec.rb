# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Service ordering" do
  include OmniauthHelper


  context "as logged in user" do
    let(:user) do
      create(:user).tap { |u| create(:project, name: "Services", user: u, reason_for_access: "To pass test") }
    end
    let(:service) { create(:service) }

    before { checkin_sign_in_as(user) }

    scenario "I see project_item service button" do
      create(:offer, service: service)

      visit service_path(service)

      expect(page).to have_text("Access the resource")
    end

    scenario "I see order open acces service button" do
      open_access_service = create(:open_access_service)
      create(:offer, service: open_access_service)

      visit service_path(open_access_service)

      expect(page).to have_text("Access the resource")
    end

    scenario "I can order service" do
      offer, _seconds_offer = create_list(:offer, 2, service: service)

      visit service_path(service)

      click_on "Access the resource", match: :first

      # Step 1
      expect(page).to have_current_path(service_offers_path(service))
      expect(page).to have_text(service.name)
      expect(page).to have_selector(:link_or_button,
                                    "Next", exact: true)

      choose "project_item_offer_id_#{offer.iid}"
      click_on "Next", match: :first

      # Step 2
      expect(page).to have_current_path(service_information_path(service))
      expect(page).to have_selector(:link_or_button,
                                    "Next - Final details", exact: true)

      click_on "Next - Final details", match: :first

      # Step 4
      expect(page).to have_current_path(service_summary_path(service))
      expect(page).to have_selector(:link_or_button,
                                    "Send access request", exact: true)

      select "Services"

      expect do
        click_on "Send access request", match: :first
      end.to change { ProjectItem.count }.by(1)
      project_item = ProjectItem.last
      expect(project_item.offer_id).to eq(offer.id)
      expect(project_item.properties).to eq([])

      # Project item page
      expect(page).to have_current_path(project_service_path(project_item.project, project_item))
      expect(page).to have_content(service.name)
    end

    scenario "I can order service with offert containing range" do
      parameter = build(:range_parameter, name: "Attribute 1", max: 100)
      offer = create(:offer, service: service,
                          parameters: [parameter])


      visit service_path(service)

      click_on "Access the resource", match: :first

      # Step 2
      expect(page).to have_current_path(service_information_path(service))
      expect(page).to have_selector(:link_or_button,
                                    "Next", exact: true)

      click_on "Next", match: :first
      # Step 3
      expect(page).to have_current_path(service_configuration_path(service))
      expect(page).to have_selector(:link_or_button,
                                    "Next - Final details", exact: true)

      fill_in "parameter_#{offer.parameters[0].id}", with: "95"

      click_on "Next - Final details", match: :first

      # Step 4
      expect(page).to have_current_path(service_summary_path(service))
      expect(page).to have_selector(:link_or_button,
                                    "Send access request", exact: true)
      select "Services"

      expect do
        click_on "Send access request", match: :first
      end.to change { ProjectItem.count }.by(1)
      project_item = ProjectItem.last
      expect(project_item.offer_id).to eq(offer.id)

      # Project item page
      expect(page).to have_current_path(project_service_path(project_item.project, project_item))
      expect(page).to have_content(service.name)
    end

    [:open_access_service, :external_service].each do |type|
      scenario "I cannot order #{type} service twice in one project if offer has no parameters" do
        service = create(type)
        _offer = create(:offer, service: service, internal: false,
                        order_type: service.order_type, order_url: service.order_url)
        _default_project = user.projects.find_by(name: "Services")

        visit service_path(service)

        click_on "Access the resource"

        # Information step
        click_on "Next", match: :first

        # Project selection
        select "Services", from: "project_item_project_id"

        expect do
          click_on "Add to a project", match: :first
        end.to change { ProjectItem.count }.by(1)

        visit service_path(service)

        click_on "Access the resource"

        # Information step
        click_on "Next", match: :first

        # Project selection
        select "Services", from: "project_item_project_id"

        expect do
          click_on "Add to a project", match: :first
          expect(page).to have_text("Please note that this resource can be added to the Project only once. Please choose another project")
        end.to change { ProjectItem.count }.by(0)
      end
    end

    [:open_access_service, :external_service].each do |type|
      scenario "I can order #{type} service twice in one project if offer has parameters" do
        service = create(type)
        _offer = create(:offer_with_parameters, service: service, internal: false,
                        order_type: service.order_type, order_url: service.order_url)
        _default_project = user.projects.find_by(name: "Services")

        visit service_path(service)

        click_on "Access the resource"
        click_on "Next", match: :first

        # Configuration step
        fill_in "parameter_#{_offer.parameters[0].id}", with: "test"

        click_on "Next - Final details", match: :first
        select "Services", from: "project_item_project_id"

        expect do
          click_on "Add to a project", match: :first
        end.to change { ProjectItem.count }.by(1)

        visit service_path(service)

        click_on "Access the resource"
        click_on "Next", match: :first

        fill_in "parameter_#{_offer.parameters[0].id}", with: "test"
        click_on "Next - Final details", match: :first
        select "Services", from: "project_item_project_id"

        expect do
          click_on "Add to a project", match: :first
        end.to change { ProjectItem.count }.by(1)
      end
    end

    scenario "Skip offers selection when only one offer" do
      create(:offer, service: service)

      visit service_path(service)

      click_on "Access the resource"

      expect(page).to have_current_path(service_information_path(service))
    end

    scenario "I'm redirected from information step into service offers when offer is not chosen" do
      create_list(:offer, 2, service: service)

      visit service_information_path(service)

      expect(page).to have_current_path(service_offers_path(service))
    end

    scenario "I'm redirected into service offers when offer is not chosen" do
      create_list(:offer, 2, service: service)

      visit service_configuration_path(service)

      expect(page).to have_current_path(service_offers_path(service))
    end

    scenario "I'm redirected into order summary when project is not chosen" do
      create(:offer, service: service)

      visit service_path(service)

      click_on "Access the resource"

      # Go directly to summary page
      visit service_summary_path(service)
      click_on "Send access request", match: :first

      expect(page).to have_current_path(service_summary_path(service))
      expect(page).to have_text("Project can't be blank")
    end

    scenario "I can order open acces service" do
      open_access_service = create(:open_access_service)
      offer = create(:open_access_offer, service: open_access_service)
      default_project = user.projects.find_by(name: "Services")

      visit service_path(open_access_service)

      click_on "Access the resource"

      # Information page
      click_on "Next", match: :first

      # Summary page
      expect(page).to have_current_path(service_summary_path(open_access_service))
      expect(page).to have_selector(:link_or_button,
                                    "Add to a project", exact: true)
      select "Services"

      expect do
        click_on "Add to a project", match: :first
      end.to change { ProjectItem.count }.by(1)
      project_item = ProjectItem.last

      expect(project_item.offer).to eq(offer)
      expect(project_item.project).to eq(default_project)
    end

    scenario "I can order catalog service" do
      external_service = create(:external_service)
      offer = create(:external_offer, service: external_service)
      default_project = user.projects.find_by(name: "Services")

      visit service_path(external_service)

      click_on "Access the resource"
      click_on "Next", match: :first

      # Summary page
      expect(page).to have_current_path(service_summary_path(external_service))
      expect(page).to have_selector(:link_or_button,
                                    "Add to a project", exact: true)
      select "Services"

      expect {
        click_on "Add to a project", match: :first
      }.to change { ProjectItem.count }.by(1)
      project_item = ProjectItem.last

      expect(project_item.offer).to eq(offer)
      expect(project_item.project).to eq(default_project)
    end

    scenario "I cannot order service without offers", js: true do
      service = create(:service)

      visit service_path(service)

      expect(page).to_not have_text("Access the service")
    end

    scenario "I can create new project on order summary view", js: true do
      Capybara.page.current_window.resize_to("1600", "1024")
      service = create(:service)
      create(:offer, service: service)

      visit service_path(service)
      # close shepherd's tour
      click_on "I'll do it later"

      click_on "Access the resource"
      click_on "Next", match: :first

      click_on "Add new project"
      within("#ajax-modal") do
        fill_in "Project name", with: "New project"
        select "Single user", from: "Customer typology"
        fill_in "Email", with: "john@doe.com"
        fill_in "Organization", with: "Home corp."
        fill_in "Webpage", with: "http://home.corp.com"
        fill_in "Reason to request access to the EOSC resources", with: "Some reason"
        select "non-European", from: "Origin country"
      end
      click_on "Create new project"

      expect(page).to have_select("project_item_project_id", selected: "New project")

      new_project = Project.all.last
      expect(new_project.name).to eq("New project")
      expect(user.projects.find { |project| project.name == "New project" }).to_not be_nil
    end

    scenario "I will stay in project edit modal while trying to create empty project", js: true do
      Capybara.page.current_window.resize_to("1600", "1024")
      service = create(:service)
      create(:offer, service: service)

      visit service_path(service)

      # close shepherd's tour
      click_on "I'll do it later"

      click_on "Access the resource"
      click_on "Next", match: :first
      click_on "Add new project"

      click_on "Create new project"
      within("#ajax-modal") do
        expect(page).to have_button("Create new project")
      end

      click_on "Create new project"
      within("#ajax-modal") do
        expect(page).to have_button("Create new project")
      end
    end

    scenario "I can create new project for private company typology", js: true do
      Capybara.page.current_window.resize_to("1600", "1024")
      service = create(:service)
      scientific_domain = create(:scientific_domain)
      create(:offer, service: service)

      visit service_path(service)

      # close shepherd's tour
      click_on "I'll do it later"

      click_on "Access the resource"
      click_on "Next", match: :first
      click_on "Add new project"
      within("#ajax-modal") do
        fill_in "Project name", with: "New project"
        fill_in "Reason to request access to the EOSC resources", with: "To pass test"
        within ".project_scientific_domains" do
          find("label", text: "Scientific domains").click
          find("div", class: "choices__item", text: scientific_domain.name).click
        end


        select "Representing a private company", from: "Customer typology"
        fill_in "Email", with: "john@doe.com"
        select "non-European", from: "Origin country"

        expect(page).to have_field("Company name")
        expect(page).to have_field("Company website url")

        fill_in "Company name", with: "New company name"
        fill_in "Company website url", with: "https://www.company.name"

        click_on "Create new project"
      end
      expect(page).to have_select("project_item_project_id", selected: "New project")
      expect(page).to have_text(scientific_domain.name)
      expect(page).to have_text("New company name")
      expect(page).to have_text("https://www.company.name")
      expect(page).to have_text("non-European")

      new_project = Project.all.last
      expect(new_project.name).to eq("New project")
      expect(user.projects.find { |project| project.name == "New project" }).to_not be_nil
    end

    scenario "Voucher inputs should not be visible in voucher disabled offer" do
      service = create(:service)
      _offer = create(:offer, service: service, voucherable: false)

      visit service_path(service)

      click_on "Access the resource"

      # Information step
      click_on "Next", match: :first

      # Step 3
      expect(page).to have_current_path(service_summary_path(service))
      expect(page).to_not have_text("Voucher")
    end

    scenario "Voucher ID input should be visible for voucher enabled service", js: true do
      Capybara.page.current_window.resize_to("1600", "1024")
      service = create(:service)
      _offer = create(:offer, service: service, voucherable: true)

      visit service_path(service)

      # close shepherd's tour
      click_on "I'll do it later"

      click_on "Access the resource"
      click_on "Next", match: :first

      # Step 2
      expect(page).to have_text("Voucher ID")
      fill_in "Voucher ID", with: "11111-22222-33333-44444"

      click_on "Next", match: :first

      # Step 3
      expect(page).to have_text("Voucher")
      expect(page).to have_text("11111-22222-33333-44444")
    end

    scenario "Voucher ID input should not be visible if 'request voucher' radio is set", js: true do
      Capybara.page.current_window.resize_to("1600", "1024")
      _offer = create(:offer, service: service, voucherable: true)

      visit service_path(service)

      # close shepherd's tour
      click_on "I'll do it later"

      click_on "Access the resource"
      click_on "Next", match: :first

      # Step 2
      find("label", id: "ask").click
      expect(page).to_not have_text("Voucher ID")

      click_on "Next", match: :first

      # Step 3
      expect(current_path).to eq service_summary_path(service)
      click_on "Back to previous step - Configuration"

      # Step 2 - again
      expect(current_path).to eq service_configuration_path(service)
      expect(page).to_not have_text("Voucher ID")
      find("label", id: "have").click
      fill_in "Voucher ID", with: "11111-22222-33333-44444"
      click_on "Next", match: :first

      # Step 3
      expect(current_path).to eq service_summary_path(service)
      expect(page).to have_text("11111-22222-33333-44444")
      click_on "Back to previous step - Configuration"

      # Step 2 - again
      expect(current_path).to eq service_configuration_path(service)
      expect(page).to have_selector("input[value='11111-22222-33333-44444']")
      find("label", id: "ask").click
      click_on "Next", match: :first

      # Step 3
      expect(current_path).to eq service_summary_path(service)
      expect(page).to_not have_text("11111-22222-33333-44444")
    end

    context "On information step" do
      scenario "I can see link to external service webpage when offert is open_access" do
        service = create(:service)
        create(:open_access_offer, service: service)

        visit service_path(service)

        click_on "Access the resource"

        expect(page).to have_link("Go to the resource")
      end

      scenario "I cannot see link to external service webpage when offert is orderable" do
        service = create(:service)
        create(:offer, service: service)

        visit service_path(service)

        click_on "Access the resource"

        expect(page).to_not have_link("Go to the service")
        expect(page).to_not have_link("Order externally")
        expect(page).to_not have_link("Link")
      end

      scenario "I can see link to external service webpage when offert is external" do
        service = create(:service)
        create(:external_offer, service: service)

        visit service_path(service)

        click_on "Access the resource"

        expect(page).to have_link("Go to the order website")
      end
    end
  end

  context "as anonymous user" do
    scenario "I can see service offers" do
      service = create(:service)
      o1, o2 = create_list(:offer, 2, service: service)

      visit service_path(service)

      expect(page).to have_selector(:link_or_button, "Access the resource", exact: true)

      click_on "Access the resource", match: :first

      expect(page).to have_text(service.name)
      expect(page).to have_text(o1.name)
      expect(page).to have_text(o2.name)
    end

    scenario "I need to log in to configure my order" do
      service = create(:service)
      create(:offer, service: service)
      user = build(:user)
      stub_checkin(user)

      visit service_offers_path(service)

      expect do
        # If new user is logged in using checkin new user record is created
        click_on "Next", match: :first
      end.to change { User.count }.by(1)

      expect(page).to have_current_path(service_summary_path(service))
      expect(User.last.full_name).to eq(user.full_name)
    end

    scenario "I can see Access the service button" do
      service = create(:service)
      create(:offer, service: service)

      visit service_path(service)

      expect(page).to have_selector(:link_or_button, "Access the resource", exact: true)
    end

    scenario "I can see openaccess service order button" do
      open_access_service =  create(:open_access_service)
      create(:offer, service: open_access_service)

      visit service_path(open_access_service)

      expect(page).to have_selector(:link_or_button, "Access the resource", exact: true)
    end

    scenario "I can see catalog service button" do
      external = create(:external_service)
      create(:offer, service: external)

      visit service_path(external)
      expect(page).to have_selector(:link_or_button, "Access the resource", exact: true)
    end
  end
end
