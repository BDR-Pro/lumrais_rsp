class CreateSellers < ActiveRecord::Migration[8.0]
  def change
    create_table :sellers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :location
      t.integer :cpu
      t.integer :ram
      t.string :public_ip
      t.boolean :available

      t.timestamps
    end
  end
end
