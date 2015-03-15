if File.exists? "#{Rails.root}/config/settings.yml"
  Settings = YAML.load_file("#{Rails.root}/config/settings.yml")[Rails.env]
else
  # heroku settings
  Settings = {
    'secret_key_base' => ENV['SECRET_KEY_BASE'],
    'ios_app_key' => ENV['IOS_APP_KEY'],

    'devise' => {
      'secret_key' => ENV['DEVISE_SECRET_KEY'],
      'mailer_sender' => ENV['DEVISE_MAILER_SENDER'] },

      'smtp' => {
        'address' => ENV['SMTP_ADDRESS'],
        'port' => 25,
        'domain' => ENV['SMTP_DOMAIN'],
        'authentication' => 'login',
        'enable_starttls_auto' => true,
        'user_name' => ENV['EMAIL_USERNAME'],
        'password' => ENV['EMAIL_PASSWORD'] },

        'qiniu' => {
          'access_key' => ENV['QINIU_ACCESS_KEY'],
          'secret_key' => ENV['QINIU_SECRET_KEY'],
          'bucket' => ENV['QINIU_BUCKET'] }
        }
end
