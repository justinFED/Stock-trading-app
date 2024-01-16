class Transaction < ApplicationRecord
  belongs_to :user
  validates_presence_of :quantity, :transaction_type, :price, :stock_symbol

  enum transaction_type: { buy: 'buy', sell: 'sell' }

  def evaluate(num1, num2)
    case transaction_type.to_sym
    when :buy
      num1 + num2
    when :sell
      num1 - num2
    end
  end


  before_create :check_if_can_proceed
  after_create :update_portfolio
  

  def total_cost
    quantity * price
  end

  def total_selling_price
    quantity * price
  end


  private

  def check_if_can_proceed
    if transaction_type == 'buy'
      user.balance >= total_cost
    elsif transaction_type == 'sell'
      user.portfolios.find_by(stock: stock_symbol).present?
    else 
      false
    end
  end


  def update_portfolio
    portfolio = user.portfolios.find_or_initialize_by(stock: stock_symbol)
    if portfolio.persisted?
      portfolio.shares = evaluate(portfolio.shares, quantity)
    else
      portfolio.shares = evaluate(0, quantity)
    end
    portfolio.save
  end
end
