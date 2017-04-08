class RemoveIndexFromOrderConfitions < ActiveRecord::Migration[5.0]
  def change
    remove_index :order_conditions, [:order_id, :condition_id]
    rename_column :condition_groups, :type, :condition_type
    remove_column :orders, :train_id
  end
end
