class AddCityNameToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :from_city_name, :string
    add_column :orders, :to_city_name, :string
  end
end
