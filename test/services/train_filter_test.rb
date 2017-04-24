require 'test_helper'

class TrainFilterTest < ActiveSupport::TestCase
  test "train number filter" do
    trains = [{"num"=>"744П", "model"=>1, "category"=>1, "travel_time"=>"6:55", "from"=>{"station"=>"Трускавець", "date"=>1493516160, "src_date"=>"2017-04-30 04:36:00"}, "till"=>{"station"=>"Дарниця", "date"=>1493541060, "src_date"=>"2017-04-30 11:31:00"}, "types"=>[{"id"=>"С1", "title"=>"Сидячий першого класу", "letter"=>"С1", "places"=>167}, {"id"=>"С2", "title"=>"Сидячий другого класу", "letter"=>"С2", "places"=>348}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}, {"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}]

    expected_trains = [{"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}]

    condition_group = {"type"=>"train", "handler_name"=>"train_number_filter", "params"=>{"train_numbers"=>["050Л", "049"]}}

    train_number_filter = TrainNumberFilter.new
    real_trains = train_number_filter.filter(trains, condition_group)

    assert real_trains.to_s == expected_trains.to_s
  end

  test "train number filter emptty result" do
    trains = [{"num"=>"744П", "model"=>1, "category"=>1, "travel_time"=>"6:55", "from"=>{"station"=>"Трускавець", "date"=>1493516160, "src_date"=>"2017-04-30 04:36:00"}, "till"=>{"station"=>"Дарниця", "date"=>1493541060, "src_date"=>"2017-04-30 11:31:00"}, "types"=>[{"id"=>"С1", "title"=>"Сидячий першого класу", "letter"=>"С1", "places"=>167}, {"id"=>"С2", "title"=>"Сидячий другого класу", "letter"=>"С2", "places"=>348}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}, {"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}]

    expected_trains = []

    condition_group = {"type"=>"train", "handler_name"=>"train_number_filter", "params"=>{"train_numbers"=>["053Л", "049"]}}

    train_number_filter = TrainNumberFilter.new
    real_trains = train_number_filter.filter(trains, condition_group)

    assert real_trains.to_s == expected_trains.to_s
  end

  test "coach type filter one value" do
    trains = [{"num"=>"744П", "model"=>1, "category"=>1, "travel_time"=>"6:55", "from"=>{"station"=>"Трускавець", "date"=>1493516160, "src_date"=>"2017-04-30 04:36:00"}, "till"=>{"station"=>"Дарниця", "date"=>1493541060, "src_date"=>"2017-04-30 11:31:00"}, "types"=>[{"id"=>"С1", "title"=>"Сидячий першого класу", "letter"=>"С1", "places"=>167}, {"id"=>"С2", "title"=>"Сидячий другого класу", "letter"=>"С2", "places"=>348}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}, {"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}]

    expected_trains = [{"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}]

    condition_group = {"type"=>"train", "handler_name"=>"coach_type_filter", "params"=>{"coach_types"=>["П"]}}
    coach_type_filter = CoachTypeFilter.new
    real_trains = coach_type_filter.filter(trains, condition_group)

    assert expected_trains.to_s == real_trains.to_s
  end

  test "coach type filter two values" do
    trains = [{"num"=>"744П", "model"=>1, "category"=>1, "travel_time"=>"6:55", "from"=>{"station"=>"Трускавець", "date"=>1493516160, "src_date"=>"2017-04-30 04:36:00"}, "till"=>{"station"=>"Дарниця", "date"=>1493541060, "src_date"=>"2017-04-30 11:31:00"}, "types"=>[{"id"=>"С1", "title"=>"Сидячий першого класу", "letter"=>"С1", "places"=>167}, {"id"=>"С2", "title"=>"Сидячий другого класу", "letter"=>"С2", "places"=>348}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}, {"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"Л", "title"=>"Люкс", "letter"=>"Л", "places"=>12}, {"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}]

    expected_trains = [{"num"=>"050Л", "model"=>0, "category"=>0, "travel_time"=>"11:14", "from"=>{"station"=>"Трускавець", "date"=>1493572560, "src_date"=>"2017-04-30 20:16:00"}, "till"=>{"station"=>"Київ-Пасажирський", "date"=>1493613000, "src_date"=>"2017-05-01 07:30:00"}, "types"=>[{"id"=>"К", "title"=>"Купе", "letter"=>"К", "places"=>130}, {"id"=>"П", "title"=>"Плацкарт", "letter"=>"П", "places"=>72}], "allow_stud"=>1, "allow_transportation"=>1, "allow_booking"=>1}]

    condition_group = {"type"=>"train", "handler_name"=>"coach_type_filter", "params"=>{"coach_types"=>["К", "П"]}}
    coach_type_filter = CoachTypeFilter.new
    real_trains = coach_type_filter.filter(trains, condition_group)

    assert expected_trains.to_s == real_trains.to_s
  end
end
