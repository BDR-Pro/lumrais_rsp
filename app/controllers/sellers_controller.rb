class SellersController < ApplicationController
  before_action :authenticate_user!

  def index
    @sellers = Seller.where(available: true)
  end

  def show
    @seller = Seller.find(params[:id])
  end

  def promote
    if current_user.buyer?
      current_user.update(role: :seller)
      create_seller_record
    end

    respond_with_role_change("You're now a seller!")
  end

  def demote
    if current_user.seller?
      # Update any associated jobs to cancelled status
      Job.where(seller_id: current_user.id).find_each do |job|
        job.update(status: Job::CANCELLED)
      end
      
      # Update user role
      current_user.update(role: :buyer)
      
      # Destroy seller record if it exists
      current_user.seller&.destroy
    end

    respond_with_role_change("You're now a buyer!")
  end

  def withdraw
    @seller = current_user.seller
    if @seller
      @transactions = @seller.transactions.where(transaction_type: :withdrawal)
    else
      redirect_to profile_path, alert: "You are not a seller."
    end
  end

  private

  def respond_with_role_change(message)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "promote-role",
          partial: "users/role_status",
          locals: { user: current_user }
        )
      end
      format.html do
        redirect_to root_path, notice: message
      end
    end
  end

  def create_seller_record
    Seller.create!(
      user: current_user,
      name: current_user.email.split("@").first.titleize,
      cpu: 4,
      ram: 8192,
      storage: 100,
      price_per_hour: 0.5,
      available: true
    )
  end
end
