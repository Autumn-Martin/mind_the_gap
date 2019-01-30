require 'rails_helper'

describe 'Api::V1::Searches API' do
  before do
    start_date = '2018-06-04'
    end_date = '2018-06-06'

    get "/api/v1/searches?start_date=#{start_date}&end_date=#{end_date}"

    @data = JSON.parse(response.body)
  end
  describe 'valid request' do
    it 'sends a successful response' do
      expect(response).to be_successful
    end
    it 'sends search data' do
      expect(@data).to have_key("search")
      expect(@data["search"].class).to eq(Hash)
      expect(@data["search"]).to have_key("startDate")
      expect(@data["search"]).to have_key("endDate")
    end
    it 'sends campsite data' do
      expect(@data).to have_key("campsites")
      expect(@data).to have_key("reservations")
      expect(@data["campsites"].class).to eq(Array)
      expect(@data["campsites"][0]).to have_key("id")
      expect(@data["campsites"][0]).to have_key("name")
    end
    it 'sends reservation data' do
      expect(@data).to have_key("reservations")
      expect(@data["reservations"].class).to eq(Array)
      expect(@data["reservations"][0]).to have_key("campsiteId")
      expect(@data["reservations"][0]).to have_key("startDate")
      expect(@data["reservations"][0]).to have_key("endDate")
    end
  end
end
