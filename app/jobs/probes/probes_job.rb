# frozen_string_literal: true

class Probes::ProbesJob < ApplicationJob
  queue_as :probes

  rescue_from(StandardError) do |exception|
  end

  def perform(body)
    url = Mp::Application.config.recommender_host + "/user_actions"
    Unirest.post url, { "Content-Type" => "application/json" }, body
  end
end
