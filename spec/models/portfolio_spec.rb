require 'rails_helper'

RSpec.describe Portfolio, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
 context 'associations' do
  it { should belong_to(:user) }
 end

 context 'validations' do
  it { should validate_presence_of(:shares) }
  it { should validate_presence_of(:stock) }
 end
 
end
