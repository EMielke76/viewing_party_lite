require 'rails_helper'

describe User do
  describe 'relationships' do
    it { should have_many(:attendees) }
    it { should have_many(:parties).through(:attendees) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }
  end

  describe 'creating a user' do
    it 'saves a valid user' do
      user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end 
end
