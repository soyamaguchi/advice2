class CreateMunicipalityInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :municipality_infos do |t|
      t.references :city, foreign_key: true
      t.string :url, null: false
      t.integer :category, null: false
      t.date :update_time, null: false
      t.string :main_title, null: false
      t.string :sub_title
      t.text :content

      t.timestamps
    end
    add_index :municipality_infos, [:city_id, :url, :main_title], unique: true
  end
end
