require 'rails_helper'

describe 'Get API' do
  let(:contents) { create_list(:content, 3) }
  let(:city) { 1 }
  let(:category) { 1 }
  it 'all contents' do
    get "/api/contents?city=#{city}&category=#{category}"

    # json = JSON.parse(response.body)

    expect(response.status).to eq(200)
  end
end