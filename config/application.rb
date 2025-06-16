require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LumraisRsp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Internationalization
    config.i18n.available_locales = [:en, :es, :fr, :de]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true
    config.time_zone = 'UTC'
    
    # Enable locale-specific formatting
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    
    # Enable timezone support
    config.active_record.default_timezone = :utc
    config.active_record.time_zone_aware_attributes = true
    
    #VPN
    config.vpn_root = ENV['VPN_ROOT'] || 'https://vpn.yourdomain.com'
  end
end
