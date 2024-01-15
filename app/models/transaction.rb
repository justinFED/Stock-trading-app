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

  validate :can_sell
  after_create :update_portfolio
  
  def total_cost
    quantity * price
  end

  def total_selling_price
    quantity * price
  end

  def can_sell
    return unless transaction_type == 'sell'
    unless user.portfolios.find_by(stock: stock_symbol).present?
      errors.add(:base, 'Trader does not own any share of this stock.')
    end
  end

  private

  def update_portfolio
    portfolio = user.portfolios.find_or_initialize_by(stock: stock_symbol)

    if portfolio.persisted?
      portfolio.shares = evaluate(portfolio.shares, quantity)
    else
      portfolio.shares = evaluate(0, quantity)
    end
  end
end
