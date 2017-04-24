require 'test_helper'

class CoachFilterTest < ActiveSupport::TestCase
  test "coach type filter" do
    coaches = [{"num"=>4, "type"=>"Л", "allow_bonus"=>false, "places_cnt"=>10, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>60955}, "coach_type_id"=>1, "scheme_id"=>1, "coach_class"=>"Б"},
      {"num"=>5, "type"=>"Л", "allow_bonus"=>false, "places_cnt"=>2, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"А"=>60955}, "coach_type_id"=>1, "scheme_id"=>1, "coach_class"=>"Б"},
      {"num"=>2, "type"=>"К", "allow_bonus"=>false, "places_cnt"=>30, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>35835}, "coach_type_id"=>3, "scheme_id"=>3, "coach_class"=>"Б"},
      {"num"=>3, "type"=>"К", "allow_bonus"=>false, "places_cnt"=>10, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>35835}, "coach_type_id"=>3, "scheme_id"=>3, "coach_class"=>"Б"},
      {"num"=>15, "type"=>"П", "allow_bonus"=>false, "places_cnt"=>12, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>15959}, "coach_type_id"=>4, "scheme_id"=>4, "coach_class"=>"Б"},
      {"num"=>16, "type"=>"П", "allow_bonus"=>false, "places_cnt"=>11, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>15959}, "coach_type_id"=>4, "scheme_id"=>4, "coach_class"=>"Б"},
      {"num"=>17, "type"=>"П", "allow_bonus"=>false, "places_cnt"=>14, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>15959}, "coach_type_id"=>4, "scheme_id"=>4, "coach_class"=>"Б"},
      {"num"=>18, "type"=>"П", "allow_bonus"=>false, "places_cnt"=>19, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>15959}, "coach_type_id"=>4, "scheme_id"=>4, "coach_class"=>"Б"}]

    condition_group = {"type"=>"coach", "handler_name"=>"price_filter", "params"=>{"max_price"=>[30000], "min_price"=>[10000]}}

    train = {"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}

    expected_coaches = [{"num"=>15, "type"=>"П", "allow_bonus"=>false, "places_cnt"=>12, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>15959}, "coach_type_id"=>4, "scheme_id"=>4, "coach_class"=>"Б"},
    {"num"=>16, "type"=>"П", "allow_bonus"=>false, "places_cnt"=>11, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>15959}, "coach_type_id"=>4, "scheme_id"=>4, "coach_class"=>"Б"},
    {"num"=>17, "type"=>"П", "allow_bonus"=>false, "places_cnt"=>14, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>15959}, "coach_type_id"=>4, "scheme_id"=>4, "coach_class"=>"Б"},
    {"num"=>18, "type"=>"П", "allow_bonus"=>false, "places_cnt"=>19, "has_bedding"=>true, "reserve_price"=>1700, "services"=>["Ч", "Ш"], "prices"=>{"Б"=>15959}, "coach_type_id"=>4, "scheme_id"=>4, "coach_class"=>"Б"}]

    price_filter = PriceFilter.new
    real_coaches = price_filter.filter(coaches, condition_group, train)

    assert real_coaches.to_s == expected_coaches.to_s
  end
end
