require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  fixtures :users
  setup do
    @user = users(:jerry)
  end

  it 'checks user is logged in and redirected to home with correct credentials' do
    expect do
      post :create, params: { user: {
          email: 'jerry@example.com',
          password: 'password'
        }
      }
    end.to change { @user.app_sessions.count }.from(0).to(1)

    expect(response).to redirect_to(root_path)
  end
end
