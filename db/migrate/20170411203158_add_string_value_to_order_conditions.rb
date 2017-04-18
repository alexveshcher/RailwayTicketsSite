class AddStringValueToOrderConditions < ActiveRecord::Migration[5.0]
  def change
    add_column :order_conditions, :string_value, :string
  end
end
