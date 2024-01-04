require 'rails_helper'

RSpec.describe Portfolio, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
 it 'belongs to a user' do
    user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@sample.com',
        password: 'password',
        role: 0,
        status: 0)

    portfolio = Portfolio.new(user: user)

    user.save!
    portfolio.save!
    portfolio.reload

    expect(portfolio.user).to eq(user)
  end
end
