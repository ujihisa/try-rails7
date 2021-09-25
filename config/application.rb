## download ./db/production.sqlite3
unless ENV['SKIP_GOOGLE_CLOUD_STORAGE'] == '1' # skip during assets:precompile
  require 'google/cloud/storage'

  credentials =
    if ENV['CREDENTIALS_JSON']
      JSON.parse(ENV['CREDENTIALS_JSON'])
    else
      'devs-sandbox-5941dd8999bb.json'
    end
  storage = Google::Cloud::Storage.new(
    project_id: 'devs-sandbox',
    credentials: credentials,
  )

  bucket = storage.bucket('try-rails7')
  file = bucket.file('production.sqlite3')
  file.download("db/#{Rails.env}.sqlite3")
end

## ok

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TryRails7
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
