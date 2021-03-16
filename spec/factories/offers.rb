# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    sequence(:iid) { |n| n }
    sequence(:name) { |n| "offer #{n}" }
    sequence(:description) { |n| "offer #{n} description" }
    sequence(:service) { |n| create(:service, offers_count: 1) }
    sequence(:status) { :published }
    sequence(:webpage) { |n| "http://webpage#{n}.invalid" }
    sequence(:order_type) { :order_required }
    sequence(:internal) { true }
    factory :offer_with_parameters do
      sequence(:parameters) { [build(:input_parameter)] }
    end

    factory :offer_with_all_parameters do
      sequence(:parameters) { [
        build(:constant_parameter),
        build(:input_parameter),
        build(:select_parameter),
        build(:multiselect_parameter),
        build(:range_parameter),
        build(:date_parameter),
        build(:quantity_price_parameter),
      ] }
    end

    factory :open_access_offer do
      sequence(:order_type) { :open_access }
    end
    factory :external_offer do
      sequence(:internal) { false }
      sequence(:order_type) { :order_required }
      sequence(:order_url) { "http://order.com" }
    end
  end
end
