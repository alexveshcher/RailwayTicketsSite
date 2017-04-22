class CoachTypeFilter
  def filter(trains, condition_group)
    result = Array.new
    coach_types = condition_group['params']['coach_types']

    trains.each do |train|
      types = train['types']
      actual_types = Array.new

      types.each do |type|
        if coach_types.include? type['id']
          actual_types << type
        end

        if(actual_types.length != 0)
          train['types'] = actual_types
          result << train
        end
      end
    end

    result
  end
end
