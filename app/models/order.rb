class Order < ApplicationRecord
  has_many :conditions, through: :order_conditions 
end
