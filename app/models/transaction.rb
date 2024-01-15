class Transaction < ApplicationRecord
  belongs_to :user
  validates_presence_of :quantity, :transaction_type, :price, :stock_symbol

  enum transaction_type: { buy: 'buy', sell: 'sell' }
  
  def total_cost
    quantity * price
  end
end
