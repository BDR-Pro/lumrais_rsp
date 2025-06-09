class SellersController < ApplicationController
  before_action :authenticate_user!

  def index
    @sellers = Seller.where(available: true)
  end

  def show
    @seller = Seller.find(params[:id])
  end
end
