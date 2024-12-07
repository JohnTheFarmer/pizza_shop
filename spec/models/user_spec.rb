require "rails_helper"

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a valid role' do
      user = build(:chef)
      expect(user).to be_valid
    end

    it 'is invalid with an invalid role' do
      user = build(:user, role: 'admin')
      expect(user).not_to be_valid
      expect(user.errors[:role]).to include('is not included in the list')
    end
  end

  describe 'default role' do
    context 'when role is not provided' do
      it 'sets the default role to customer before validation' do
        user = build(:user, email: 'test@example.com', password: 'password')
        user.validate
        expect(user.role).to eq('customer')
      end
    end

    context 'when role is provided' do
      it 'does not override the provided role' do
        user = build(:chef, email: 'test@example.com', password: 'password')
        user.validate
        expect(user.role).to eq('chef')
      end
    end
  end

  describe 'Devise modules' do
    let!(:user) { create(:customer, email: 'test@example.com', password: 'password') }

    it 'authenticates with valid credentials' do
      expect(User.find_for_authentication(email: 'test@example.com').valid_password?('password')).to be true
    end

    it 'rejects authentication with invalid credentials' do
      expect(User.find_for_authentication(email: 'test@example.com').valid_password?('wrongpassword')).to be false
    end
  end
end
