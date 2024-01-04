require 'rails_helper'

RSpec.describe Portfolio, type: :model do
    it 'belongs to a user' do
        expect(subject).to belong_to(:user)
    end

    it 'validates presence of stock' do
        expect(subject).to validate_presence_of(:stock)
    end
end
