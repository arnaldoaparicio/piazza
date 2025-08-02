require 'rails_helper'

RSpec.describe User, type: :model do
  context 'creating a new User' do
    it 'requires a name' do
      user = User.new(name: '', email: 'johndoe@example.com')

      expect(user.valid?).to eq(false)

      user.name = 'John'
      expect(user.valid?).to eq(true)
    end

    it 'requires a valid email' do
      user = User.new(name: '', email: 'johndoe@example.com')

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
  end
end
