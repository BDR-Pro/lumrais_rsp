class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_seller, only: [:seller]

  def index
    @user = current_user
    @recent_jobs = current_user.jobs.order(created_at: :desc).limit(5)
    @recent_transactions = current_user.transactions.order(created_at: :desc).limit(5)
    @total_earnings = current_user.transactions.where(transaction_type: :deposit, status: :success).sum(:amount)
    @total_spent = current_user.transactions.where(transaction_type: :withdrawal, status: :success).sum(:amount)
  end

  def seller
    @seller = current_user.seller
    @active_jobs = @seller.seller_jobs.active.order(created_at: :desc)
    @recent_earnings = @seller.user.transactions.where(transaction_type: :deposit, status: :success).order(created_at: :desc).limit(5)
    @total_earnings = @seller.total_earnings
    @available_resources = @seller.available_resources
  end

  private

  def require_seller
    unless current_user.seller?
      redirect_to dashboard_path, alert: "You must be a seller to access this page."
    end
  end
end 