class PlaceQuantityFilter
  def filter(places, condition_group, train, coach)
    if places.length >= condition_group['places_quantity']
      return places
    end

    return Array.new
  end
end
