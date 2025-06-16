require 'sidekiq'
require 'sidekiq-scheduler'

redis_config = {
  url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1'),
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
}

Sidekiq.configure_server do |config|
  config.redis = redis_config
  
  # Enable scheduled jobs
  config.on(:startup) do
    Sidekiq.schedule = {
      'cleanup_old_records' => {
        'cron' => '0 0 * * *',  # Run daily at midnight
        'class' => 'CleanupJob'
      }
    }
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end 