class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :set_security_headers

  # Allow public access to the landing page
  skip_before_action :authenticate_user!, only: [:home, :csp_report]

  def home
    render "pages/landing"
  end

  def csp_report
    # Log CSP violations
    Rails.logger.warn("CSP Violation: #{request.body.read}")
    head :ok
  end

  private

  def set_security_headers
    response.headers['X-Frame-Options'] = 'DENY'
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['X-XSS-Protection'] = '1; mode=block'
    response.headers['Referrer-Policy'] = 'strict-origin-when-cross-origin'
  end
end
