class Order < ApplicationRecord
  has_many :conditions, through: :order_conditions
  has_many :order_conditions
  has_many :condition_groups, through: :conditions
end
