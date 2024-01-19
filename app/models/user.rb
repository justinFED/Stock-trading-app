class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates_presence_of :first_name, :last_name, :role
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  attr_accessor :top_up_amount

  has_many :portfolios
  has_many :transactions

  enum role: { trader: 0, admin: 1 }
  enum status: { pending: 0, approved: 1}

  before_create :set_default_values
  after_create :send_status_email

  def top_up_balance(amount)
    self.balance += amount
    save
  end

  private

  def set_default_values
    self.role ||= :trader
    self.status ||= :pending
    self.balance ||= 0
  end

  def send_status_email
    if approved?
      UserMailer.approved_email(self).deliver_later
    else
      UserMailer.pending_email(self).deliver_later
    end
  end

end
