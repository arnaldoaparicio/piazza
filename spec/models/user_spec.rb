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
      user = User.new(name: '', email: 'johndoe@example.com', password: 'password')

      expect(user.valid?).to eq(false)

      user.name = 'John'
      expect(user.valid?).to eq(true)
    end

    it 'requires a valid email' do
      user = User.new(name: 'John', email: '', password: 'password')

      expect(user.valid?).to eq(false)

      user.email = 'invalid'
      expect(user.valid?).to eq(false)

      user.email = 'johndoe@example.com'
      expect(user.valid?).to eq(true)
    end

    it 'requires a unique email' do
      existing_user = User.create(name: 'John', email: 'jd@example.com', password: 'password')
      expect(existing_user.persisted?).to eq(true)

      user = User.new(name: 'Jon', email: 'jd@example.com', password: 'password')
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
      expect(user.valid?).to eq(true)

      max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
      user.password = 'a' * (max_length + 1)
      expect(user.valid?).to_not eq(true)
    end
  end

  context 'logging in as a User' do
    it 'can create a session with email and correct password' do
      app_session = User.create_app_session(email: 'jerry@example.com', password: 'password')

      expect(app_session).to_not eq(nil)
      expect(app_session.token).to_not eq(nil)
    end

    it 'cannot create a session with email and incorrect password' do
      app_session = User.create_app_session(email: 'jerry@example.com', password: 'WRONG')

      expect(app_session).to eq(nil)
    end

    it 'creates a session with non existent email and returns nil' do
      app_session = User.create_app_session(email: 'whoami@example.com', password: 'WRONG')

      expect(app_session).to eq(nil)
    end
  end
end
