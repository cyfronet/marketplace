# frozen_string_literal: true

class Services::InlineOrderUrlComponent < ApplicationComponent
  include ProjectItemsHelper

  def initialize(offerable:, classes: "btn btn-outline-primary mt-3")
    @offerable = offerable
    @classes = classes
  end

  def call
    link_to link_name, url,
            class: @classes, target: "_blank", title: "External link", "data-probe": ""
  end

  def url
    webpage(@offerable)
  end

  def link_name
    if @offerable.external
      _("Go to the order website")
    else
      _("Go to the resource")
    end
  end

  def render?
    !url.blank? && (!@offerable.order_required? || @offerable.external)
  end
end
