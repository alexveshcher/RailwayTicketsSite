require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { described_class.new(password: "some_password", email: "john@doe.com", role: 'user')}

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).not_to be_valid
    end

    it "is valid without defining role" do
      expect(described_class.new(password: "some_password", email: "john@doe.com")).to be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end


    it "is valid with admin role" do
      subject.role = 'admin'
      expect(subject).to be_valid
    end

    # it "is not valid with role gopnik" do
    #   expect(User.new(password: "some_password", email: "john@doe.com", role: 'gopnik')).to raise_exception
    # end


  end
end
