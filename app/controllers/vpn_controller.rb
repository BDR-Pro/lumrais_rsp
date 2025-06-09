class VpnController < ApplicationController
  before_action :authenticate_user!

  def config
    seller = Seller.find(params[:id])
    template = File.read(Rails.root.join("config/vpn/template.ovpn"))
    rendered = template.gsub("{{SERVER_IP}}", seller.public_ip)

    send_data rendered,
      filename: "lumrais_#{seller.name.parameterize}.ovpn",
      type: "application/x-openvpn-profile"
  end
end
