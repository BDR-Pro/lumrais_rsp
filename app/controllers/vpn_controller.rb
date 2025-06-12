class VpnController < ApplicationController
  before_action :authenticate_user!

  def config
    seller = Seller.find(params[:id])
    raise "Access Denied" unless seller.user == current_user

    # Customize base template
    config_path = Rails.root.join("app", "assets", "vpn", "lumrais.ovpn")
    raise "Configuration file not found" unless File.exist?(config_path)
    base_config = File.read(config_path)

    personalized = base_config.gsub("{{COMMON_NAME}}", seller.name.parameterize)

    send_data personalized,
      filename: "lumrais_#{seller.name.parameterize}.ovpn",
      type: "application/x-openvpn-profile"
  end
end
