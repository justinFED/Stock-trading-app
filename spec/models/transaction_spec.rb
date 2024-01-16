require 'rails_helper'

RSpec.describe Transaction, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
 context 'associations' do
  it { should belong_to(:user) }
 end

 context 'validations' do
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:transaction_type) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:stock_symbol) }
 end

end
