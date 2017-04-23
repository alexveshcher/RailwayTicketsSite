class PlaceTypeFilter
  def filter(places, condition_group, train, coach)

    if condition_group['params']['place_types'].empty?
      return places
    end

    place_types = condition_group['params']['place_types']

    if coach['type'] != 'П' && coach['type'] != 'К'
      return places
    end

    result = Array.new

    place_types.each do |place_type|
      if place_type == 'down'
        result = result + down_filter(places)
      elsif place_type == 'up'
        result = result + up_filter(places)
      end
    end

    result
  end

  def up_filter(places)
    new_places = Array.new

    places.each do |place|
      if !place.to_i.odd?
        new_places << place
      end
    end
    new_places
  end

  def down_filter(places)
    new_places = Array.new

    places.each do |place|
      if place.to_i.odd?
        new_places << place
      end
    end
    new_places
  end
end
