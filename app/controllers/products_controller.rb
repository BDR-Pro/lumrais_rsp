class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.active.includes(:seller)
    @products = @products.by_seller(params[:seller_id]) if params[:seller_id].present?
    @products = @products.order(created_at: :desc)
  end

  def show
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end 