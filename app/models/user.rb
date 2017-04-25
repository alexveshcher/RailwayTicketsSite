class User < ApplicationRecord
  before_validation :set_default_role
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: {user: 'user', admin: 'admin'}
  validates :role, inclusion: { in: roles }

  private
  def set_default_role
    if(self.role.nil?)
      self.role = 'user'
    end

  end
end
