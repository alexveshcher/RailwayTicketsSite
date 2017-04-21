require_relative '../../lib/services/api/ukr_railway.rb'

class PlacesController < ApplicationController
  def get_stations
    p_name = params[:name]
    ukrRailway = UkrRailway.new

    stations = ukrRailway.get_stations(p_name)
    render json: stations
  end
end
