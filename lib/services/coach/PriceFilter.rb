class PriceFilter
  def filter(coaches, condition_group, train)
    result = Array.new

    min_price = condition_group['min_price']
    max_price = condition_group['max_price']

    coaches.each do |coach|
      coach_class = coach['coach_class']
      price = coach['prices'][coach_class]

      if price > min_price && price < max_price
        result << coach
      end
    end
    result
  end
end
