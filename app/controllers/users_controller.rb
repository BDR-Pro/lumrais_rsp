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
    vpn_ip = next_available_vpn_ip # Implement logic

    Seller.create!(
      user: current_user,
      name: current_user.email.split("@").first.titleize,
      cpu: 4,
      ram: 8192,
      vpn_ip: vpn_ip,
      available: true
    )
  end

  def next_available_vpn_ip
    used_ips = Seller.pluck(:vpn_ip)
    base = IPAddr.new("10.8.0.2")
    loop do
      candidate = base.to_s
      return candidate unless used_ips.include?(candidate)
      base = base.succ
    end
  end

end
