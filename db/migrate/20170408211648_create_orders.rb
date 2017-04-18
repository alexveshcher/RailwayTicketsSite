class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :from_city_id
      t.integer :to_city_id
      t.date :from_date
      t.date :to_date
      t.integer :train_id, null: false
      t.integer :task_id
      t.string :status

      t.timestamps
    end
  end
end
