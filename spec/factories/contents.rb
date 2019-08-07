FactoryBot.define do
  factory :content do
    city_id { 1 }
    prefecture { 大阪府 }
    city　{ 大阪市 }
    ward {  }
    category_id { 35 }
    category_name { "test-category" }
    url { "https://www.google.co.jp/" }
    update_time { Date.strptime("2019年8月6日", "%Y年%m月%d日") }
    main_title { "test-title" }
    sub_title { "test-sub-title" }
    content { "testcontents" }
  end
end