class CreateConditionParams < ActiveRecord::Migration[5.0]
  def change
    create_table :condition_params do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
