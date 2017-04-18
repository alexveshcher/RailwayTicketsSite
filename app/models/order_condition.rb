class OrderCondition < ApplicationRecord
  belongs_to :condition_param, required: false
  belongs_to :order
  belongs_to :condition
end
