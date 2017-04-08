class Condition < ApplicationRecord
  belongs_to :condition_group
  has_many :condition_params
  has_many :orders, through: :order_conditions
end
