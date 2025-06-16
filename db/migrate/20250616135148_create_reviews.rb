class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :job, null: false, foreign_key: true
      t.integer :reviewer_id, null: false
      t.integer :reviewee_id, null: false
      t.integer :rating
      t.text :comment

      t.timestamps
    end

    add_foreign_key :reviews, :users, column: :reviewer_id
    add_foreign_key :reviews, :users, column: :reviewee_id
  end
end
