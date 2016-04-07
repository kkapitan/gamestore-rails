class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, index: true, foreign_key: true
      t.references :game, index: true, foreign_key: true

      t.string :title
      t.integer :mark
      t.string :body

      t.timestamps null: false
    end
  end
end
