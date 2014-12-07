Rails.application.configure do
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: Settings['smtp']['address'],
    port: Settings['smtp']['port'],
    domain: Settings['smtp']['domain'],
    authentication: Settings['smtp']['authentication'],
    enable_starttls_auto: Settings['smtp']['enable_starttls_auto'],
    user_name: Settings['smtp']['user_name'],
    password: Settings['smtp']['password']
  }
end
