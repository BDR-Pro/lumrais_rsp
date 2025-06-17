class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :cpu_cores, null: false
      t.integer :ram_gb, null: false
      t.integer :storage_gb, null: false
      t.boolean :featured, default: false
      t.boolean :active, default: true
      t.references :seller, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :products, :featured
    add_index :products, :active
  end
end 