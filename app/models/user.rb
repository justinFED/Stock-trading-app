class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates_presence_of :first_name, :last_name, :role

  has_many :portfolios

  enum role: { trader: 0, admin: 1 }
  enum status: { pending: 0, approved: 1}

  before_create :set_default_values

  private

  def set_default_values
    self.role ||= :trader
    self.status ||= :pending
  end

end
