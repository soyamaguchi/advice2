FactoryBot.define do
  factory :content do
    id { 361 }
    city_id { 10 }
    url { "https://www.city.osaka.lg.jp" }
    category { 30 }
    main_title { "test-title_01" }
  end
end