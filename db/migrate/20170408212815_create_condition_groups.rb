class CreateConditionGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :condition_groups do |t|
      t.string :condition_name
      t.string :type

      t.timestamps
    end
  end
end
