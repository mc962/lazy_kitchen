require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LazyKitchen
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Map ActionPolicy Forbidden errors to Rails error handling
    config.action_dispatch.rescue_responses.merge!(
      {
        'ActionPolicy::Unauthorized' => :forbidden
      }
    )
    # Allow custom error pages
    config.exceptions_app = self.routes

    # Do not destroy existing attachments on new attachment upload
    config.active_storage.replace_on_assign_to_many = false

    # S3 Bucket for site assets and uploaded files
    config.x.application_bucket = 'lazy-kitchen'
    # Path prefix for S3 resources item files (such as images) (defaults to dev path)
    config.x.resource_prefix = 'resources/dev'
  end
end
