require 'rails_helper'

RSpec.describe User, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
 it 'is valid with valid attributes' do 
    user = User.new(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john.doe@sample.com',
      password: 'password',
      role: 0,
      status: 0
    )
    user.save
    expect(user).to be_valid
  end

  context 'validations' do
    it 'requires first_name' do
      user = User.new(first_name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'requires last_name' do
      user = User.new(last_name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'requires email' do
      user = User.new(email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'requires a unique email' do
      existing_user = User.create(
        first_name: 'Existing',
        last_name: 'User',
        email: 'existing@sample.com',
        password: 'password',
        role: 0,
        status: 0
      )

      user = User.new(
        first_name: 'New',
        last_name: 'User',
        email: 'existing@sample.com',
        password: 'password',
        role: 0,
        status: 0
      )

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'requires password' do
      user = User.new(password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'requires role' do
      user = User.new(role: nil)
      expect(user).not_to be_valid
      expect(user.errors[:role]).to include("can't be blank")
    end
  end
end