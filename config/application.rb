# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require 'action_mailbox/engine'
# require 'action_text/engine'
require 'action_view/railtie'
# require 'action_cable/engine'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RspGame
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    I18n.available_locales = %i[en ru]
    config.i18n.default_locale = :en

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = 'Central Time (US & Canada)'
    # config.eager_load_paths << Rails.root.join('extras')

    config.active_record.schema_format = :sql

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.generators do |g|
      g.test_framework :rspec, fixtures: true, views: false, view_specs: false, helper_specs: false,
          routing_specs: false, controller_specs: true, request_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.stylesheets false
      g.javascripts false
      g.helper false
    end

    # Catch 404s
    config.after_initialize do |app|
      app.routes.append { match '*path', to: 'application#page_not_found', via: :all }
    end
  end
end
