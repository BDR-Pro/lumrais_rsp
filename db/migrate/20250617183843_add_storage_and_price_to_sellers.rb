class AddStorageAndPriceToSellers < ActiveRecord::Migration[8.0]
  def change
    add_column :sellers, :storage, :integer
    add_column :sellers, :price_per_hour, :decimal
  end
end
