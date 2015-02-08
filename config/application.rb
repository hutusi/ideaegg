require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ideaegg
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end

if File.exists? "#{Rails.root}/config/settings.yml"
  Settings = YAML.load_file("#{Rails.root}/config/settings.yml")[Rails.env]
else
  # heroku settings
  Settings = {
    secret_key_base: ENV['SECRET_KEY_BASE'],
    ios_app_key: ENV['IOS_APP_KEY'],

    devise: {
      secret_key: ENV['DEVISE_SECRET_KEY'],
      mailer_sender: ENV['DEVISE_MAILER_SENDER'] },
      
      smtp: {
        address: ENV['SMTP_ADDRESS'],
        port: 25,
        domain: ENV['SMTP_DOMAIN'],
        authentication: 'login',
        enable_starttls_auto: true,
        user_name: ENV['EMAIL_USERNAME'],
        password: ENV['EMAIL_PASSWORD'] },

        qiniu: {
          access_key: ENV['QINIU_ACCESS_KEY'],
          secret_key: ENV['QINIU_SECRET_KEY'],
          bucket: ENV['QINIU_BUCKET'] }
        }
end
