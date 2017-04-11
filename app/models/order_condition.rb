class OrderCondition < ApplicationRecord
  belongs_to :condition_param, optional: true
  belongs_to :order
  belongs_to :condition
end
