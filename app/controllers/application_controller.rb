class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  # Allow public access to the landing page
  skip_before_action :authenticate_user!, only: [:home]
  def home
    render "pages/landing"
  end
end
