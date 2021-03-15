# frozen_string_literal: true

module Service::Search
  extend ActiveSupport::Concern

  included do
    # ELASTICSEARCH
    # scope :search_import working with should_indexe?
    # and define which services are indexed in elasticsearch
    searchkick word_middle: [:name, :tagline, :description, :offer_names, :provider_names],
      highlight: [:name, :tagline]
  end

  # search_data are definition whitch
  # fields are mapped to elasticsearch
  def search_data
    {
      service_id: id,
      name: name,
      tagline: tagline,
      description: description,
      status: status,
      rating: rating,
      categories: categories.map(&:id),
      scientific_domains: search_scientific_domains_ids,
      providers: providers.map(&:id),
      platforms: platforms.map(&:id),
      geographical_availabilities: geographical_availabilities.map(&:alpha2),
      target_users: target_users.map(&:id),
      order_type: [order_type] << offers.map(&:order_type),
      tags: tag_list,
      source: upstream&.source_type,
      offers: offers.ids,
      offer_names:  offers.map(&:name),
      provider_names: [resource_organisation.name] << providers.map(&:name)
    }
  end

  private
    def search_scientific_domains_ids
      (scientific_domains.map(&:ancestor_ids) + scientific_domains.map(&:id))
        .flatten.uniq
    end
end
