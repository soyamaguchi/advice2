FactoryBot.define do
  factory :municipality_info do
    city_id { 10 }
    url { "https://www.city.osaka.lg.jp" }
    category { 30 }
    update_time { Date.strptime("2019年8月6日", "%Y年%m月%d日") }
    main_title { "test-title" }
    sub_title { "test-sub-title" }
    content { "testsample" }
  end
end