class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.references :city, foreign_key: true, null: false
      t.string :url, null: false
      t.integer :category, null: false
      t.string :main_title, null: false

      t.timestamps
    end
    add_index :contents, [:city_id, :url, :main_title], unique: true
  end
end
