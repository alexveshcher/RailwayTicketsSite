# require_relative '../train/coach_type_filter.rb'
# require_relative '../place/place_type_filter.rb'
# require_relative '../last/place_quantity_filter.rb'
# require_relative '../coach/price_filter.rb'
# require_relative '../train/train_number_filter.rb'

class FilterResolver

  def get_filters(condition_groups)
    filters = Hash.new
    filters['train'] = []
    filters['coach'] = []
    filters['place'] = []
    filters['last'] = []

    condition_groups.each do |condition_group|
      filters[condition_group['type']] << get_filter(condition_group['handler_name'], condition_group)
    end

    filters
  end

  def get_filter(handler_name, condition_group)
    if handler_name == 'train_number_filter'
      return {'filter' => TrainNumberFilter.new, 'condition_group' => condition_group}
    elsif handler_name == 'coach_type_filter'
      return {'filter' => CoachTypeFilter.new, 'condition_group' => condition_group}
    elsif handler_name == 'place_quantity_filter'
      return {'filter' => PlaceQuantityFilter.new, 'condition_group' => condition_group}
    elsif handler_name == 'place_type_filter'
      return {'filter' => PlaceTypeFilter.new, 'condition_group' => condition_group}
    elsif handler_name == 'price_filter'
      return {'filter' => PriceFilter.new, 'condition_group' => condition_group}
    end
  end
end
