require 'test_helper'

class ConveterTest < ActiveSupport::TestCase
  test "converter test" do
    expected_result = [{"type"=>"place", "handler_name"=>"place_type_filter", "params"=>{"place_types"=>["up", "down"]}},
    {"type"=>"train", "handler_name"=>"coach_type_filter", "params"=>{"coach_types"=>["П"]}},
    {"type"=>"coach", "handler_name"=>"price_filter", "params"=>{"max_price"=>[30000], "min_price"=>[20]}},
    {"type"=>"last", "handler_name"=>"place_quantity_filter", "params"=>{"places_quantity"=>[4]}},
    {"type"=>"train", "handler_name"=>"train_number_filter", "params"=>{"train_numbers"=>["050Л"]}}]

    order = Order.all[0]

    orderConditionConverter = OrderConditionConverter.new
    actual_result = orderConditionConverter.convert(order.order_conditions)

    assert expected_result.to_s == actual_result.to_s
  end
end
