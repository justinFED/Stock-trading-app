class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates_presence_of :first_name, :last_name, :role, :status

  has_many :portfolios

  enum role: { trader: 0, admin: 1 }
  enum status: { pending: 0, approved: 1}
end
