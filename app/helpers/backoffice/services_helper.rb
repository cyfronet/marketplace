# frozen_string_literal: true

module Backoffice::ServicesHelper
  BADGES = {
    "published" => "badge-success",
    "unverified" => "badge-warning",
    "draft" => "badge-error",
    "deleted" => "badge-error"
  }

  def service_status(service)
    content_tag(:span, service.status, class: "badge #{BADGES[service.status]}")
  end

  def offers_status(service)
    if service.offers.blank?
      content_tag(:span, "NO OFFERS", class: "badge badge-error")
    elsif service.published? && service.offers.published.blank?
      content_tag(:span, "NO PUBLISHED OFFERS", class: "badge badge-warning")
    end
  end

  def collapsed?(service, fields)
    (service.errors.keys & fields).blank?
  end

  def offer_status(offer)
    content_tag(:span, offer.status, class: "badge #{BADGES[offer.status]}")
  end

  def array_inputs(name, form)
    render "backoffice/services/array_entry", name: name, form: form
  end

  def array_templates(form, name)
    content_tag(:div, class: "array-wrapper", "data-target" => "service.#{name}") do
      concat content_tag(:input, class: "form-control text optional",
                         "disabled": cant_edit(["#{name}": []]),
                         "as": :array, "multiple": true)
      concat content_tag(:a, "Add",
                         class: "float-right add-button",
                         "data-action": "click->service#addNewArrayField",
                         "data-wrapper": "service_#{name}",
                         "data-class" => "form-control text optional"
                        )
      concat content_tag(:span)
    end
  end

  def array_item(form)
    concat content_tag(:li, I18n.t("parameters.#{clazz.type}.add"),
                       class: "list-group-item",
                       "data-template": parameter_template(clazz.new(id: "js_template_id"), form),
                       "data-action": "click->offer#selectParameterType",
                       "data-target": "offer.attributeType")
  end
end
