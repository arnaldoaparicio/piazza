require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'relationships' do
    it { should have_many(:memberships) }
    it { should have_many(:members).through(:memberships).source(:user) }
  end
end