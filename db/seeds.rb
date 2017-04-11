Condition.create!([
  {name: "train_numbers", value_type: "S", condition_group_id: 3, sysname: nil},
  {name: "coach_types", value_type: "C", condition_group_id: 4, sysname: nil},
  {name: "max_price", value_type: "I", condition_group_id: 5, sysname: nil},
  {name: "min_price", value_type: "I", condition_group_id: 5, sysname: nil},
  {name: "place_type", value_type: "C", condition_group_id: 7, sysname: nil},
  {name: "places_quantity", value_type: "I", condition_group_id: 6, sysname: nil}
])
ConditionGroup.create!([
  {condition_name: "Place type", condition_type: "place", handler_name: "place_type_filter"},
  {condition_name: "Coach type", condition_type: "train", handler_name: "coach_type_filter"},
  {condition_name: "Price", condition_type: "coach", handler_name: "price_filter"},
  {condition_name: "Place quantity", condition_type: "last", handler_name: "place_quantity_filter"},
  {condition_name: "Train number", condition_type: "train", handler_name: "train_number_filter"}
])
ConditionParam.create!([
  {name: "Плацкарт", value: "П", condition_id: 2},
  {name: "Нижнє місце", value: "down", condition_id: 4}
])
Order.create!([
  {from_city_id: 2218155, to_city_id: 2200001, from_date: "2017-04-29", to_date: "2017-04-29", task_id: 228, status: "Open"}
])
OrderCondition.create!([
  {order_id: 1, condition_id: 1, number_value: nil, condition_param_id: nil, string_value: "050Л"},
  {order_id: 1, condition_id: 2, number_value: nil, condition_param_id: 1, string_value: nil},
  {order_id: 1, condition_id: 4, number_value: nil, condition_param_id: 2, string_value: nil},
  {order_id: 1, condition_id: 5, number_value: 2, condition_param_id: nil, string_value: nil},
  {order_id: 1, condition_id: 6, number_value: 0, condition_param_id: nil, string_value: nil},
  {order_id: 1, condition_id: 3, number_value: 150000, condition_param_id: nil, string_value: nil}
])
