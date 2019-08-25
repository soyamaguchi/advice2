require 'rails_helper'

describe 'Get Api' do
  before(:all) do
    # cityの生成
    create(:city)
    # categoryの生成
    create_list(:category, 4)
    # contentの生成
    create_list(:content, 4)
    # municipality_infoの生成
    create_list(:municipality_info, 4)
  end

  # 大阪府 id
  let(:city_id) { 1 }
  # 大阪府 子育て category_id
  let(:category_id) { 3 }

  # 正常系
  context 'get_contents' do
    it 'all contents' do
      get "/api/contents?q[city]=#{city_id}&q[category]="
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['contents'].first['city_id']).to eq(city_id)
      expect(json['contents'].first['category_name']).to eq('行政オンラインサービス')
      if ENV['RAILS_ENV'] == 'test'
        expect(json['contents'].last['category_name']).to eq('教育')
      elsif ENV['RAILS_ENV'] == 'development'
        expect(json['contents'].last['category_name']).to eq('市民活動・コミュニティ')
      end
    end
    it 'category contents' do
      get "/api/contents?q[city]=#{city_id}&q[category]=#{category_id}"
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['contents'].first['city_id']).to eq(city_id)
      expect(json['contents'].first['category_id']).to eq(category_id)
      expect(json['contents'].first['category_name']).to eq('子育て')
    end
  end
  # 異常系
  context 'cannot_get_contents' do
    it 'no params' do
      get '/api/contents?q[city]=&q[category]='
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['contents'].length).to eq(0)
    end
    it 'params illegal' do
      get "/api/contents?q[cities]=#{city_id}&q[category]="
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['contents'].length).to eq(0)
    end
    it 'excluded' do
      get '/api/contents?q[city]=100&q[category]=100'
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['contents'].length).to eq(0)
    end
  end
end