require 'rails_helper'

describe 'Api::V1::Campsites API' do
  before do
    start_date = '2018-06-04'
    end_date = '2018-06-06'

    get "/api/v1/campsites/available?start_date=#{start_date}&end_date=#{end_date}"

    @data = JSON.parse(response.body)
  end
  describe 'valid request' do
    it 'sends a successful response' do
      expect(response).to be_successful
    end
    it 'sends the expected available campsites' do
      expected = ["Comfy Cabin", "Rickety Cabin", "Cabin in the Woods"]
      expect(@data).to eq(expected)
    end
  end
end
