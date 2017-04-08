class OrderCondition < ApplicationRecord
  belongs_to :condition_param
  belongs_to :orders
  belongs_to :conditions
end
