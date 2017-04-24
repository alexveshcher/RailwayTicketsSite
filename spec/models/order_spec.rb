require 'rails_helper'

# Test suite for the Order model
RSpec.describe Order, type: :model do
  subject { described_class.new }

  it "is not valid without a from_city_id" do
    expect(subject).to_not be_valid
  end

  it "is valid with valid attributes" do
    order = Order.new({from_city_id: 554, to_city_id: 8457, from_date: "2017-04-24", user_id: 1, status: 'Completed' })
    expect(order).to be_valid
  end

  it "is not valid with date_from == yesterday" do
    date = Date.today - 1.day
    order = Order.new({from_city_id: 554, to_city_id: 8457, from_date: date , user_id: 1, status: 'Completed' })
    expect(order).not_to be_valid
  end

  it "is not valid with date_from more than 45 days after today" do
    date = Date.today + 50.days
    order = Order.new({from_city_id: 554, to_city_id: 8457, from_date: date, user_id: 1, status: 'Completed' })
    expect(order).not_to be_valid
  end

end
