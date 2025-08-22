require 'rails_helper'

RSpec.describe AppSession, type: :model do
  fixtures :users
  before(:each) do
    @user = users(:jerry)
  end

  it 'generates and saves a token when a new record is created' do
    app_session = @user.app_sessions.create

    expect(app_session.persisted?).to eq(true)
    expect(app_session.token_digest).to_not eq(nil)
    binding.pry
  end
end
