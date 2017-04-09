class OrderCondition < ApplicationRecord
  belongs_to :condition_param
  belongs_to :order
  belongs_to :condition
end
