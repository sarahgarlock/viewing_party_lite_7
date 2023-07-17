require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :user_parties }
    it { should have_many(:parties).through(:user_parties)}
  end
  
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password_digest)}
    it {should have_secure_password}
  end

  describe 'instance methods' do
    it 'can validate a user' do
      user = User.create!(name: 'Bob', email: 'bob@gmail.com', password: 'password', password_confirmation: 'password')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password')
    end
  end
end