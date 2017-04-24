require 'test_helper'

class PlacesControllerTest < ActionDispatch::IntegrationTest
  test "should get get_station" do
    get places_get_station_url
    assert_response :redirect
  end

end
