class Order < ApplicationRecord
  has_many :conditions, through: :order_conditions
  has_many :order_conditions
  has_many :condition_groups, through: :conditions
  belongs_to :user
  belongs_to :task
  accepts_nested_attributes_for :order_conditions, :allow_destroy => true
  validates :from_city_id, :to_city_id, :from_date, presence: true
  validates :status, inclusion: { in: %w(Unaccepted Expired Failed Completed Open),
      message: "%{value} is not a valid status" }
  validates :from_date,
              date: { after: Proc.new { Date.today - 1.day },
                      before: Proc.new { Date.today + 45.days } }

  def expired?
    Time.now.to_date > from_date.to_date
  end

end
