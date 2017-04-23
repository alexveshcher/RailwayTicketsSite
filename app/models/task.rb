class Task < ApplicationRecord
    has_many :cycles
    has_many :orders
end
