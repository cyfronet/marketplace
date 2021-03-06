# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Question about provider" do
  include OmniauthHelper

  scenario "cannot be send when contact emails are empty" do
    provider = create(:provider)

    visit provider_path(provider)

    expect(page).to_not have_content "Ask this provider a question"
  end

  context "as logged in user" do
    before { checkin_sign_in_as(create(:user)) }

    scenario "I can send question to contact emails", js: true do
      Capybara.page.current_window.resize_to("1600", "1024")
      provider = create(:provider)
      create_list(:public_contact, 2, contactable: provider)

      visit provider_path(provider)

      click_on "Ask this provider a question"

      within("#ajax-modal") do
        fill_in("provider_question_text", with: "text")
      end

      expect do
        click_on "SEND"
        expect(page).to have_content("Your message was successfully sent")
      end.to change { ActionMailer::Base.deliveries.count }.by(2)
    end

    scenario "I cannot send message about service with empty message", js: true do
      Capybara.page.current_window.resize_to("1600", "1024")
      provider = create(:provider)
      create_list(:public_contact, 2, contactable: provider)

      visit provider_path(provider)

      click_on "Ask this provider a question"

      click_on "SEND"

      expect(page).to have_content("Text Question cannot be blank")
    end
  end

  context "as not logged in user" do
    scenario "I can send message about provider", js: true do
      Capybara.page.current_window.resize_to("1600", "1024")
      provider = create(:provider)
      create_list(:public_contact, 2, contactable: provider)

      visit provider_path(provider)

      click_on "Ask this provider a question"

      within("#ajax-modal") do
        fill_in("provider_question_author", with: "John Doe")
        fill_in("provider_question_email", with: "john.doe@company.com")
        fill_in("provider_question_text", with: "text")
      end

      expect do
        click_on "SEND"
        expect(page).to have_content("Your message was successfully sent")
      end.to change { ActionMailer::Base.deliveries.count }.by(2)
    end

    scenario "I cannot send message about provider with empty fields", js: true do
      Capybara.page.current_window.resize_to("1600", "1024")
      provider = create(:provider)
      create_list(:public_contact, 2, contactable: provider)

      visit provider_path(provider)

      click_on "Ask this provider a question"

      click_on "SEND"

      expect(page).to have_content("Author can't be blank")
      expect(page).to have_content("Email can't be blank and Email is not a valid email address")
      expect(page).to have_content("Text Question cannot be blank")
    end
  end
end
