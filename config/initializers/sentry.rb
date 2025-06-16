Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.environment = Rails.env
  config.enabled_environments = %w[production staging]
  
  # Set traces_sample_rate to 1.0 to capture 100% of transactions for performance monitoring
  config.traces_sample_rate = 0.2
  
  # Enable performance monitoring
  config.enable_tracing = true
  
  # Set a uniform sample rate between 0.0 and 1.0
  config.traces_sampler = lambda do |context|
    true
  end
  
  # Filter sensitive data
  config.before_send = lambda do |event, hint|
    if event.exception
      event.exception.values.each do |exception|
        exception.value = exception.value.gsub(/password=([^&]+)/, 'password=[FILTERED]')
      end
    end
    event
  end
end 