class PriceFilter
  def filter(coaches, condition_group, train)
    result = Array.new

    if condition_group['params']['min_price'].empty? || condition_group['params']['max_price'].empty?
      return coaches
    end

    min_price = condition_group['params']['min_price'][0]
    max_price = condition_group['params']['max_price'][0]

    coaches.each do |coach|
      coach_class = coach['coach_class']
      price = coach['prices'].values[0]
      if price > min_price && price < max_price
        result << coach
      end
    end
    result
  end
end
