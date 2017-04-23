class Order < ApplicationRecord
  has_many :conditions, through: :order_conditions
  has_many :order_conditions
  has_many :condition_groups, through: :conditions
  belongs_to :user
  belongs_to :task
  accepts_nested_attributes_for :order_conditions, :allow_destroy => true
end
