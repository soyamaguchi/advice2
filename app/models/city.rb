class City < ApplicationRecord
  has_many :contents
  has_many :categories
end
