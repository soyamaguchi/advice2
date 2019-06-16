class AddNotNullToCategories < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :city_id, :bigint, null: false
    change_column :categories, :category_id, :integer, null: false
    change_column :categories, :category_name, :string, null: false
  end
end
