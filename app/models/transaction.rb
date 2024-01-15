class Transaction < ApplicationRecord
  belongs_to :user
  validates_presence_of :quantity, :transaction_type, :price, :stock_symbol
end
