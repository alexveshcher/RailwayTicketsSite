class AddHandlerNameToConditionGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :condition_groups, :handler_name, :string
    add_foreign_key :order_conditions, :orders, column: :order_id, primary_key: :id
    add_foreign_key :order_conditions, :conditions, column: :condition_id, primary_key: :id
  end
end
