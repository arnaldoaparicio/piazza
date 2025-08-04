require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'relationships' do
    it { should have_many(:memberships) }
    it { should have_many(:organizations).through(:memberships) }
  end
  context 'creating a new User' do
    it 'requires a name' do
      user = User.new(name: '', email: 'johndoe@example.com')

      expect(user.valid?).to eq(false)

      user.name = 'John'
      expect(user.valid?).to eq(true)
    end

    it 'requires a valid email' do
      user = User.new(name: 'John', email: '')

      expect(user.valid?).to eq(false)

      user.email = 'invalid'
      expect(user.valid?).to eq(false)

      user.email = 'johndoe@example.com'
      expect(user.valid?).to eq(true)
    end

    it 'requires a unique email' do
      existing_user = User.create(name: 'John', email: 'jd@example.com')
      expect(existing_user.persisted?).to eq(true)

      user = User.new(name: 'Jon', email: 'jd@example.com')
      expect(user.valid?).to eq(false)
    end

    it 'is stripped of spaces in name and email before saving' do
      user = User.create(name: ' John ', email: ' johndoe@example.com ')

      expect(user.name).to eq('John')
      expect(user.email).to eq('johndoe@example.com')
    end

    it "should have a password length between 8 and ActiveModel's maximum" do
      user = User.new(name: 'Jane', email: 'janedoe@example.com', password: '')
      expect(user.valid?).to eq(false)

      user.password = 'password'
      expect(user.valid?).to eq(false)

      max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
      user.password = 'a' * (max_length + 1)
      expect(user.valid?).to eq(true)
    end
  end
end
