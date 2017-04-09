class TrainNumberFilter

  def filter(trains, condition_group)

    result = Array.new
    train_numbers = condition_group['train_numbers']

    trains.each do |train|
      num = train['num']

      if train_numbers.include? num
        result << train
      end
    end

    result
  end
end
