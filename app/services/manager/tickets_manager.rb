# require_relative '../api/ukr_railway.rb'
# require_relative 'filters_resolver.rb'
require 'time'

class TicketsManager
  def find_acceptable_tickets(station_id_from, station_id_till, departure_date, condition_groups)

    train_coaches = Array.new
    last_preparation = Array.new
    result = Array.new

    filter_resolver = FilterResolver.new
    ukr_railway = UkrRailway.new

    filters = filter_resolver.get_filters condition_groups

    trains = ukr_railway.get_tickets_beetwen_stations(station_id_from, station_id_till, departure_date)['value']

    trains_filters = filters['train']
    coaches_filters = filters['coach']
    places_filters = filters['place']
    last_filters = filters['last']

    trains_filters.each do |trains_filter|
      trains = trains_filter['filter'].filter(trains, trains_filter['condition_group'])
    end

    # trains are collected
    # it's time to collect coaches

    if coaches_filters.empty? && places_filters.empty? && last_filters.empty?
      return trains
    end

    trains.each do |train|
      coaches = Array.new

      train_id = train['num']
      types = train['types']

      types.each do |type|
        type_id = type['id']
        available_coaches = ukr_railway.get_tickets_for_train(station_id_from, station_id_till, Time.parse(departure_date).to_i, train_id, type_id)['coaches']
        coaches = coaches + available_coaches
      end

      coaches_filters.each do |coaches_filter|
        coaches = coaches_filter['filter'].filter(coaches, coaches_filter['condition_group'], train)
      end

      if coaches.length > 0
        train_coaches << {'train' => train, 'coaches' => coaches}
      end
    end

    # coaches are collected
    # it's time to collect places

    if places_filters.empty? && last_filters.empty?
      return train_coaches
    end

    train_coaches.each do |train_coach|
      current_train = train_coach['train']
      current_train_id = current_train['num']

      current_coaches = train_coach['coaches']
      new_coaches = Array.new

      current_coaches.each do |current_coach|

        current_coach_id = current_coach['coach_type_id']
        current_coach_num = current_coach['num']
        current_coach_class = current_coach['coach_class']

        places = ukr_railway.get_tickets_for_coach(station_id_from, station_id_till, Time.parse(departure_date).to_i, current_train_id, current_coach_id, current_coach_num)['value']['places'][current_coach_class]

        places_filters.each do |place_filter|
          places = place_filter['filter'].filter(places, place_filter['condition_group'], current_train, current_coach)
        end

        if places.length > 0
           new_coaches << {'coach' => current_coach, 'places' => places}
        end
      end

      if new_coaches.length > 0
        last_preparation << {'train' => current_train, 'coaches' => new_coaches}
      end
    end

    if last_filters.empty?
      return last_preparation
    end

    # places are collected
    # it's time to use the last filters

    last_preparation.each do |example|
      last_coaches = example['coaches']
      last_train = example['train']

      new_coaches = Array.new

      last_coaches.each do |last_coach|

        places = last_coach['places']
        last_filters.each do |last_filter|
          places = last_filter['filter'].filter(places, last_filter['condition_group'], last_train, last_coach['coach'])
        end

        if places.length > 0
           new_coaches << {'coach' => last_coach['coach'], 'places' => places}
        end
      end

      if new_coaches.length > 0
        result << {'train' => last_train, 'coaches' => new_coaches}
      end
    end

    puts result

    result
  end
end

 # t = TicketsManager.new
 # t.find_acceptable_tickets(2218155, 2200001, '29.04.2017', [
 #   {"type"=>"train", "handler_name"=>"train_number_filter", "params"=>{"train_numbers"=>["050Л"]}},
 #   {"type"=>"train", "handler_name"=>"coach_type_filter", "params"=>{"coach_types"=>["П"]}},
 #   {"type"=>"place", "handler_name"=>"place_type_filter", "params"=>{"place_type"=>["down"]}},
 #   {"type"=>"last", "handler_name"=>"place_quantity_filter", "params"=>{"places_quantity"=>[2]}},
 #   {"type"=>"coach", "handler_name"=>"price_filter", "params"=>{"min_price"=>[0], "max_price"=>[150000]}}])
