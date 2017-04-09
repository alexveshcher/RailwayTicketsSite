class ReferenceConditionToConditionParams < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :condition_params, :conditions, column: :condition_id, primary_key: :id
  end
end
