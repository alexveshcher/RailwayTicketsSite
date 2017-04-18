class CreateOrderConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :order_conditions do |t|
      t.integer :order_id
      t.integer :condition_id
      t.integer :number_value
      t.references :condition_param, foreign_key: true
      t.index [:order_id, :condition_id], unique: true


      t.timestamps
    end
  end
end
