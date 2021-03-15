# frozen_string_literal: true

module Service::Autocomplete
  extend ActiveSupport::Concern

  def autocomplete
    query = Searchkick.search(params[:q],
                              fields: ["name", "offer_name", "provider_name"],
                              operator: "or",
                              match: :word_middle,
                              limit: 5,
                              load: false,
                              where: { service_id: scope.ids },
                              highlight: { multiple: true, tag: "<b>" },
                              models: [Service, Offer],
                              model_includes: { Service => [:offers], Offer => [:service] })

    service_titles = Service.where(id: scope.ids).pluck(:id, :name).to_h

    if request.xhr?
      render(template: "services/autocomplete/list",
             locals: { results: query.with_highlights, service_titles: service_titles },
             layout: false)
    end
  end
end
