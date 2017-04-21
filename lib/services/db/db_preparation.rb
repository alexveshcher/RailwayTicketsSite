class DbPreparation

  # require_relative 'lib/services/db/db_preparation'
  # d = DbPreparation.new
  # d.install
  def install
    place_type = ConditionGroup.new({condition_name: "Place type", condition_type: "place", handler_name: "place_type_filter"})
    coach_type = ConditionGroup.new({condition_name: "Coach type", condition_type: "train", handler_name: "coach_type_filter"})
    price = ConditionGroup.new({condition_name: "Price", condition_type: "coach", handler_name: "price_filter"})
    place_quantity = ConditionGroup.new({condition_name: "Place quantity", condition_type: "last", handler_name: "place_quantity_filter"})
    train_number = ConditionGroup.new({condition_name: "Train number", condition_type: "train", handler_name: "train_number_filter"})

    place_type.save
    coach_type.save
    price.save
    place_quantity.save
    train_number.save

    train_numbers = Condition.new({name: "Train numbers", value_type: "S", condition_group_id: train_number.id, sysname: "train_numbers"})
    coach_types = Condition.new({name: "Coach types", value_type: "C", condition_group_id: coach_type.id, sysname: "coach_types"})
    place_types = Condition.new({name: "Place types", value_type: "C", condition_group_id: place_type.id, sysname: "place_types"})
    max_price = Condition.new({name: "Max price", value_type: "I", condition_group_id: price.id, sysname: "max_price"})
    places_quantity = Condition.new({name: "Quantity of places", value_type: "I", condition_group_id: place_quantity.id, sysname: "places_quantity"})
    min_price = Condition.new({name: "Min price", value_type: "I", condition_group_id: price.id, sysname: "min_price"})

    train_numbers.save
    coach_types.save
    place_types.save
    max_price.save
    min_price.save
    places_quantity.save

    plats = ConditionParam.new({name: "Плацкарт", value: "П", condition_id: coach_types.id})
    down_place = ConditionParam.new({name: "Нижнє місце", value: "down", condition_id: place_types.id})

    plats.save
    down_place.save
  end
end
