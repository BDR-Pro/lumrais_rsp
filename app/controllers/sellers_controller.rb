class SellersController < ApplicationController
  before_action :authenticate_user!

  def index
    @sellers = Seller.where(available: true)
  end

  def show
    @seller = Seller.find(params[:id])
  end
  def withdraw
    @seller = current_user.seller
    if @seller
      @transactions = @seller.transactions.where(transaction_type: :withdrawal)
    else
      redirect_to profile_path, alert: "You are not a seller."
    end
  end
end
