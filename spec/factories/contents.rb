FactoryBot.define do
  factory :content do
    sequence(:id, 100) { |i| i }
    city_id { 1 }
    url { "https://www.city.osaka.lg.jp" }
    sequence(:category, 1) { |i| i }
    main_title { "test-title_#{category}" }
  end
end