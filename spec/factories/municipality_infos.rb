FactoryBot.define do
  factory :municipality_info do
    city_id { 1 }
    url { "https://www.city.osaka.lg.jp" }
    sequence(:category) { |i| i }
    update_time { Date.strptime("2019年8月6日", "%Y年%m月%d日") }
    main_title { "test-title_#{category}" }
    sub_title { "test-sub-title" }
    content { "testsample" }
  end
end