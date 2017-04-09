require_relative '../train/CoachTypeFilter.rb'
require_relative '../place/PlaceTypeFilter.rb'
require_relative '../last/PlaceQuantityFilter.rb'
require_relative '../coach/PriceFilter.rb'
require_relative '../train/TrainNumberFilter.rb'

class FilterResolver

  def getFilters(condition_groups)
    filters = Hash.new
    filters['train'] = []
    filters['coach'] = []
    filters['place'] = []
    filters['last'] = []

    condition_groups.each do |condition_group|
      filters[condition_group['type']] << getFilter(condition_group['handler_name'], condition_group)
    end

    filters
  end

  def getFilter(handler_name, condition_group)
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
