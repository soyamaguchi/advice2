class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :prefecture
      t.string :city
      t.string :ward
      t.string :url

      t.timestamps
    end
  end
end
