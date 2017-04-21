class PlaceTypeFilter
  def filter(places, condition_group, train, coach)
    place_type = condition_group['params']['place_type'][0]

    if place_type != 'down' || coach['type'] != 'П'
      return places
    end

    new_places = Array.new

    places.each do |place|
      if place.to_i.odd?
        new_places << place
      end
    end
    new_places
  end
end
