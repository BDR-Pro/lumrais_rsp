class HealthController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def show
    health_status = {
      status: 'ok',
      timestamp: Time.current,
      version: Rails.application.config.version,
      environment: Rails.env,
      database: database_status,
      redis: redis_status
    }

    render json: health_status
  end

  private

  def database_status
    ActiveRecord::Base.connection.execute('SELECT 1')
    'ok'
  rescue StandardError => e
    'error'
  end

  def redis_status
    Redis.new.ping
    'ok'
  rescue StandardError => e
    'error'
  end
end 