# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.autoload_paths << Rails.root.join("lib")

    default_redis_url = if Rails.env == "test" then "redis://localhost:6379/1" else "redis://localhost:6379/0" end

    config.redis_url = ENV["REDIS_URL"] || default_redis_url

    # View customization
    config.paths['app/views'].unshift(ENV["CUSTOM_VIEWS_PATH"]) if ENV["CUSTOM_VIEWS_PATH"].present?

    # Locales customization
    config.i18n.load_path += if ENV["CUSTOM_LOCALES_PATH"].present?
                               Dir[Pathname.new(ENV["CUSTOM_LOCALES_PATH"]).join('**', '*.{rb,yml}')]
                             else
                               Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
                             end

    config.portal_base_url = "https://eosc-portal.eu"
    config.portal_base_url = ENV["PORTAL_BASE_URL"] if ENV["PORTAL_BASE_URL"].present?

    config.providers_dashboard_url = "https://catalogue.eosc-portal.eu"
    config.providers_dashboard_url = ENV["PROVIDERS_DASHBOARD_URL"] if ENV["PROVIDERS_DASHBOARD_URL"].present?
  end
end
