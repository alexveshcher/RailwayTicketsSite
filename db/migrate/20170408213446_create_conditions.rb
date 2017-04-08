class CreateConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions do |t|
      t.string :name
      t.string :value_type
      t.references :condition_group, foreign_key: true

      t.timestamps
    end
  end
end
