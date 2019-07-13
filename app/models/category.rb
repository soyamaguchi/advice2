class Category < ApplicationRecord
  belongs_to :city

  validates :city_id, presence: true
  validates :category_id, presence: true
  validates :category_name, presence: true
end
