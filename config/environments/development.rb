Contractor::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  # Send mail (yes, really!)
  config.action_mailer.perform_deliveries = true
  # for devise
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Set delivery method for development to :letter_opener
  config.action_mailer.delivery_method = :letter_opener
  # config.action_mailer.delivery_method = :smtp
  
  config.action_mailer.smtp_settings = {
    :enable_starttls_auto =>  true,
    :address              =>  'smtp.gmail.com',
    :port                 =>  '587',               # '465',
    # :tls                 =>  true,
    :domain               =>  'onosono.com',
    :authentication       =>  :plain,             # :login,
    :user_name            =>  'info@onosono.com',
    :password             =>  ENV['EMAIL_PASSWORD_SUPPORT_ONOSONO']
  }

  # Set base url of Contractor
  config.base_url = "http://localhost:3000/"

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Debug mode disables concatenation and preprocessing of assets.
  config.assets.debug = true

  # Do not show assets in log
  config.assets.logger = false

  # Set generators
  config.generators do |g|
    g.template_engine :haml
    g.helper false
    g.test_framework :rspec, :fixture =>false, :view_specs => false, :helper_specs => false
  end
end
