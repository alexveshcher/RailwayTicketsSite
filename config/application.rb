require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailwayTickets
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.sass.preferred_syntax = :sass
    config.enable_dependency_loading = true

    # config.cache_store = :redis_store, {
    #   host: "localhost",
    #   port: 6379,
    #   db: 0,
    #   password: "mysecret",
    #   namespace: "cache"
    # }
  end
end
