class Order < ApplicationRecord
  has_many :conditions, through: :order_conditions
  has_many :order_conditions
  has_many :condition_groups, through: :conditions
  accepts_nested_attributes_for :order_conditions, :allow_destroy => true
end
