class AddTasksAndCycle < ActiveRecord::Migration[5.0]
  def change

    create_table :tasks do |t|
      t.string :task_string_id
      t.integer :fails_count
      t.timestamps
    end

    create_table :cycles do |t|
      t.integer :execution_time
      t.string :error_message
      t.string :service_message 
      t.boolean :success
      t.integer :task_id
      t.timestamps
    end

    add_foreign_key :cycles, :tasks, column: :task_id, primary_key: :id
    add_foreign_key :orders, :tasks, column: :task_id, primary_key: :id


  end
end
