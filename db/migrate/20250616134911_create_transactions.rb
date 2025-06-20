class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.integer :transaction_type
      t.integer :status

      t.timestamps
    end
  end
end
