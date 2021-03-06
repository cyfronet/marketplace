# frozen_string_literal: true

class Services::DetailsController < ApplicationController
  include Service::Comparison
  layout :choose_layout

  def choose_layout
    if params[:from] == "backoffice_service"
      "backoffice"
    elsif params[:from] == "ordering_configuration"
      "ordering_configuration"
    else
      "application"
    end
  end

  def index
    @service = Service.friendly.find(params[:service_id])
    @related_services = @service.related_services
    @related_services_title = "Related resources"
    @question = Service::Question.new(service: @service)
  end
end
