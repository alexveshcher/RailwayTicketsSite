class OrderConditionConverter
  def convert(order_conditions, from_id, to_id, date)
    result = Hash.new

    order_conditions.each do |order_condition|
      current_condition = order_condition.condition
      current_condition_group = current_condition.condition_group

      saved_condition_group = result[current_condition_group.id]

      if saved_condition_group.nil?
        result[current_condition_group.id] = Hash.new
        result[current_condition_group.id]['type'] = current_condition_group.condition_type
        result[current_condition_group.id]['handler_name'] = current_condition_group.handler_name
        result[current_condition_group.id]['params'] = Hash.new

        saved_condition_group = result[current_condition_group.id]
      end

      current_condition_values = saved_condition_group['params'][current_condition.id]

      if current_condition_values.nil?
        saved_condition_group['params'][current_condition.sysname] = Array.new
        current_condition_values = saved_condition_group['params'][current_condition.id]
      end

      if current_condition.value_type == 'C'
        saved_condition_group['params'][current_condition.sysname] << order_condition.condition_param.value
      elsif current_condition.value_type == 'I'
        saved_condition_group['params'][current_condition.sysname] << order_condition.number_value
      else
        saved_condition_group['params'][current_condition.sysname] << order_condition.string_value
      end
    end

    result.values
  end
end

# [
#   {"type"=>"train", "handler_name"=>"train_number_filter", "params"=>[{"train_numbers"=>["050Л"]}]},
#   {"type"=>"train", "handler_name"=>"coach_type_filter", "params"=>[{"coach_types"=>["П"]}]},
#   {"type"=>"coach", "handler_name"=>"price_filter", "params"=>[{"max_price"=>[0]}, {"min_price"=>[0]}]},
#   {"type"=>"last", "handler_name"=>"place_quantity_filter", "params"=>[{"place_type"=>["down"]}]},
#   {"type"=>"place", "handler_name"=>"place_type_filter", "params"=>[{"places_quantity"=>[2]}]}]
