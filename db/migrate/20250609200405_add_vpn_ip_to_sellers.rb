class AddVpnIpToSellers < ActiveRecord::Migration[8.0]
  def change
    add_column :sellers, :vpn_ip, :string
  end
end
