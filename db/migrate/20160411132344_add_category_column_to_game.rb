class AddCategoryColumnToGame < ActiveRecord::Migration
  def change
    add_column :games, :category_cd, :string
  end
end
