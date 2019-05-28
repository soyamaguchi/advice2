class CreateMunicipalityInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :municipality_infos do |t|
      t.references :city, foreign_key: true
      t.string :url
      t.string :main_title
      t.string :sub_title
      t.text :content

      t.timestamps
    end
  end
end
