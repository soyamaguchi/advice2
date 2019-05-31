class AddNotNullToCities < ActiveRecord::Migration[5.2]
  def change
    change_column :cities, :prefecture, :string, null: false
    change_column :cities, :url, :string, null: false
  end
end
