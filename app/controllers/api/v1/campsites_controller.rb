class Api::V1::CampsitesController < ApplicationController
  def available
    search_data = Api::V1::SearchesSerializer.new(params["start_date"], params["end_date"]).search_data
    available_campsites = Api::V1::AvailableCampsiteRetriever.new(search_data).updated_available_campsites

    render json: available_campsites
  end
end
