class AddSysnameToConditions < ActiveRecord::Migration[5.0]
  def change
    add_column :conditions, :sysname, :string
    add_index :conditions, :name, unique: true
  end
end
