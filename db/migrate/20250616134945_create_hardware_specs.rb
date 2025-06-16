class CreateHardwareSpecs < ActiveRecord::Migration[8.0]
  def change
    create_table :hardware_specs do |t|
      t.references :seller, null: false, foreign_key: true
      t.string :cpu
      t.string :gpu
      t.string :ram
      t.string :storage
      t.string :bandwidth

      t.timestamps
    end
  end
end
