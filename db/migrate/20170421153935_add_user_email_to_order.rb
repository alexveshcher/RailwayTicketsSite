class AddUserEmailToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :user_id, :integer
    add_foreign_key :orders, :users, column: :user_id, primary_key: :id
  end
end
