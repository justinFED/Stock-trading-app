FactoryBot.define do
  factory :transaction do
    association :user 
    stock_symbol { "AAPL" }
    quantity { 5 }
    price { "10.00" }
    transaction_type { "buy" }
  end
end
