class Content < ApplicationRecord
  belongs_to :city

  validates :city_id, presence: true
  validates :url, presence: true
  validates :category, presence: true
  validates :main_title, presence: true
end
