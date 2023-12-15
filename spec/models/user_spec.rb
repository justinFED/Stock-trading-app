require 'rails_helper'

RSpec.describe User, type: :model do
    context 'validations' do
        it 'validates presence of first_name' do
            expect(subject).to validate_presence_of(:first_name)
        end

        it 'validates presence of last_name' do
            expect(subject).to validate_presence_of(:last_name)
        end

        it 'validates presence of email' do
            expect(subject).to validate_presence_of(:email)
        end

        #role -> if admin ba or trader
        it 'validates presence of role' do
            expect(subject).to validate_presence_of(:role)
        end

        #status -> if pending or approved
        it 'validates presence of status' do
            expect(subject).to validate_presence_of(:status)
        end

        it 'has many transactions' do
            expect(subject).to have_many(:transactions)
        end
    end
end




