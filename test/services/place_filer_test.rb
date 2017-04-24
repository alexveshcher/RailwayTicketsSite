require 'test_helper'

class PlaceFilterTest < ActiveSupport::TestCase
  test "place type filter kupe down" do
    condition_group = {"type"=>"place", "handler_name"=>"place_type_filter", "params"=>{"place_types"=>["down"]}}
    train = {"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}
    places = [30, 34, 36, 37, 38, 39, 40, 42, 44, 46, 50, 52]
    coach = {"num"=>2, "type"=>"К", "allow_bonus"=>false, "places_cnt"=>30, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>35835}, "coach_type_id"=>3, "scheme_id"=>3, "coach_class"=>"Б"}

    expected_places = [37, 39]

    place_filter = PlaceTypeFilter.new
    actual_places = place_filter.filter(places, condition_group, train, coach)

    assert ((expected_places-actual_places) + (actual_places-expected_places)).blank?
  end

  test "place type filter kupe up" do
    condition_group = {"type"=>"place", "handler_name"=>"place_type_filter", "params"=>{"place_types"=>["up"]}}
    train = {"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}
    places = [30, 34, 36, 37, 38, 39, 40, 42, 44, 46, 50, 52]
    coach = {"num"=>2, "type"=>"К", "allow_bonus"=>false, "places_cnt"=>30, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>35835}, "coach_type_id"=>3, "scheme_id"=>3, "coach_class"=>"Б"}

    expected_places = [30, 34, 36, 38, 40, 42, 44, 46, 50, 52]

    place_filter = PlaceTypeFilter.new
    actual_places = place_filter.filter(places, condition_group, train, coach)

    assert ((expected_places-actual_places) + (actual_places-expected_places)).blank?
  end

  test "place type filter kupe up down" do
    condition_group = {"type"=>"place", "handler_name"=>"place_type_filter", "params"=>{"place_types"=>["up", "down"]}}
    train = {"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}
    places = [30, 34, 36, 37, 38, 39, 40, 42, 44, 46, 50, 52]
    coach = {"num"=>2, "type"=>"К", "allow_bonus"=>false, "places_cnt"=>30, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>35835}, "coach_type_id"=>3, "scheme_id"=>3, "coach_class"=>"Б"}

    expected_places = [30, 34, 36, 37, 38, 39, 40, 42, 44, 46, 50, 52]

    place_filter = PlaceTypeFilter.new
    actual_places = place_filter.filter(places, condition_group, train, coach)

    assert ((expected_places-actual_places) + (actual_places-expected_places)).blank?
  end

  test "place type filter luks down" do
    condition_group = {"type"=>"place", "handler_name"=>"place_type_filter", "params"=>{"place_types"=>["down"]}}
    train = {"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}
    places = [30, 34, 36, 37, 38, 39, 40, 42, 44, 46, 50, 52]
    coach = {"num"=>2, "type"=>"Л", "allow_bonus"=>false, "places_cnt"=>30, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>35835}, "coach_type_id"=>3, "scheme_id"=>3, "coach_class"=>"Б"}

    expected_places = [30, 34, 36, 37, 38, 39, 40, 42, 44, 46, 50, 52]

    place_filter = PlaceTypeFilter.new
    actual_places = place_filter.filter(places, condition_group, train, coach)

    assert ((expected_places-actual_places) + (actual_places-expected_places)).blank?
  end
end
