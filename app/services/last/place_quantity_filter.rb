class PlaceQuantityFilter
  def filter(places, condition_group, train, coach)

    if condition_group['params']['places_quantity'].empty?
      return places
    end

    if places.length >= condition_group['params']['places_quantity'][0]
      return places
    end

    return Array.new
  end
end
