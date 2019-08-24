require 'rails_helper'

describe MunicipalityInfo, type: :model do
  describe 'municipality_info model ut' do
    if ENV['RAILS_ENV'] == 'test'
      let!(:city) { City.create(id: 1, prefecture: "TEST", city: "test", ward: "", url: "https://github.com") }
    end
    let(:municipality_info) { MunicipalityInfo.new(params) }
    let(:params) { { city_id: 1,
                     url: "https://github.com/soyamaguchi",
                     category: 30,
                     update_time: Date.strptime("2019年8月6日", "%Y年%m月%d日"),
                     main_title: "test-title",
                     sub_title: "test-sub-title",
                     content: "testtesttest" } }
    context 'municipality_info valid' do
      it 'valid' do
        expect(municipality_info).to be_valid
      end
      it 'save' do
        expect(municipality_info.save).to be_truthy
      end
    end
    context 'municipality_info invalid' do
      let(:municipality_info_cp) { MunicipalityInfo.new(city_id: 1,
                                                       url: "https://github.com/soyamaguchi",
                                                       category: 31,
                                                       update_time: Date.strptime("2019年8月7日", "%Y年%m月%d日"),
                                                       main_title: "test-title",
                                                       sub_title: "test-sub-title",
                                                       content: "testtesttest") }
      it 'invalid save' do
        municipality_info.save
        expect{ municipality_info_cp.save }.to raise_error
      end
    end
  end
end
