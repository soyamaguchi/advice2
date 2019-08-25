FactoryBot.define do
  factory :content do
    sequence(:id) { |i| i }
    city_id { 1 }
    url { "https://www.city.osaka.lg.jp" }
    sequence(:category) { |i| i }
    main_title { "test-title_#{category_id}" }
  end
end