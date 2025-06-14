class UsersController < ApplicationController
  before_action :authenticate_user!

  def promote
    if current_user.buyer?
      current_user.update(role: :seller)
      create_seller_record
    end

    respond_with_role_change("You're now a seller!")
  end

  def demote
    if current_user.seller?
      current_user.update(role: :buyer)
      current_user.seller&.destroy
    end

    respond_with_role_change("You're now a buyer!")
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
      available: true
    )
  end


end
