class PagesController < ApplicationController
  
  skip_before_action :authenticate_user!, only: [:landing]

  def download
  end

  def quick_run
  end

  def infra_action
  end

  def landing
    @featured_products = Product.featured.limit(3)
    @recent_jobs = Job.completed.order(created_at: :desc).limit(3)
    return redirect_to sellers_path if user_signed_in?
  end

  def products
    @products = Product.all
  end

  def about
  end

  def contact
  end

  def terms
  end

  def privacy
  end

  def settings
    @user = current_user
    @seller = @user.seller if @user.seller?
  end
end
