FactoryBot.define do
  factory :city do
    id { 1 }
    prefecture { "大阪府" }
    city { "大阪市" }
    ward {  }
    url { "https://www.city.osaka.lg.jp" }
  end
end