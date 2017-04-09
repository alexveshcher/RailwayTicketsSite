class AddConditionIdToConditionParams < ActiveRecord::Migration[5.0]
  def change
    add_reference(:condition_params, :condition)
  end
end
