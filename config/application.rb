require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wydawnictwo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    #
    #
    config.available_locales = [:pl, :en]
    config.time_zone = 'Warsaw'
    config.i18n.default_locale = :pl
    config.active_record.schema_format = :sql

  end
end

require 'book_serializer'
require 'importer'
require 'mapper'
