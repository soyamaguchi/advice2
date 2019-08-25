FactoryBot.define do
  factory :category do
      sequence(:id) { |i| i }
      city_id { 1 }
      sequence(:category_id, 1) { |i| i }
      category_name { category_id == 1 ? "行政オンラインサービス" : category_id == 2 ? "妊娠・出産" : category_id == 3 ? "子育て" : "教育" }
  end
end