require_relative 'boot'
require 'warden'

require 'rails/all'
require 'will_paginate/array'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Articles
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.assets.paths << Rails.root.join("node_modules")
    config.middleware.use Warden::Manager
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:4000' # Adjust this to match your Blog Partner app's domain
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
