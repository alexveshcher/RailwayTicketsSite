# require_relative '../../lib/services/api/ukr_railway.rb'

class PlacesController < ApplicationController
  def get_stations
    p_name = params[:name]
    ukrRailway = UkrRailway.new

    formatted_stations = []

    stations = ukrRailway.get_stations(p_name)
    puts " stations found #{stations}"

    if stations.nil? 
      puts "PlacesController.get_stations: returns nil"
    else
      stations.each do |station|
        formatted_stations << {:id => station['value'], :label => station['title']}
      end
    end
    render json: formatted_stations
  end
end
