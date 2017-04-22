class TrainNumberFilter
  def filter(trains, condition_group)

    if condition_group['params']['train_numbers'].empty?
      return trains
    end

    result = Array.new
    train_numbers = condition_group['params']['train_numbers']

    trains.each do |train|
      num = train['num']

      if train_numbers.include? num
        result << train
      end
    end

    result
  end
end
