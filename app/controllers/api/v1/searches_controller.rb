class Api::V1::SearchesController < ApplicationController
  def index
    # search_data = Api::V1::SearchesSerializer.new(params["start_date"], params["end_date"]).search_data
    search_data = Api::V1::SearchesSerializer.new(params["start_date"], params["end_date"]).campsite_names
    render json: search_data
  end
end
