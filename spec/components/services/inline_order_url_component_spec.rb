# frozen_string_literal: true

require "rails_helper"

RSpec.describe Services::InlineOrderUrlComponent, type: :component do
  [:open_access, :fully_open_access, :other].each do |type|
    it "shows button go to the service depending on #{type} order_type" do
      offer = create(:offer, order_type: type)
      render_inline(Services::InlineOrderUrlComponent.new(offerable: offer))

      expect(page).to have_link("Go to the resource")
    end
  end

  it "shows button order externally depending on external order_type" do
    offer = create(:external_offer)
    render_inline(Services::InlineOrderUrlComponent.new(offerable: offer))

    expect(page).to have_link("Go to the order website")
  end

  it "hides button with webpage if order_required order_type" do
    offer = create(:offer, internal: true)

    render_inline(Services::InlineOrderUrlComponent.new(offerable: offer))
    expect(page).to_not have_link("Order externally")
    expect(page).to_not have_link("Go to the resource")
  end
end
