require "rails_helper"

RSpec.describe UsersController, type: :controller do
  it 'redirects to feed afer successful sign up' do
    get :new
    expect(response).to have_http_status(:ok)

    expect do
      post :create, params: { user: {
        name: 'John',
        email: 'johndoe@example.com',
        password: 'password'
      }
    }
    end.to change { User.count }.from(0).to(1).and change { Organization.count }.from(0).to(1)

    expect(response).to redirect_to(root_path)
  end

  it 'renders errors if input is invalid' do
    get :new

    expect do
      post :create, params: { user: {
        name: 'John',
        email: 'johndoe@example.com',
        password: 'pass'
      }
    }
    end.to_not change { User.count }
    expect(Organization.all.count).to eq(0)
    expect(response).to have_http_status(:unprocessable_content)
    expect(response).to_not redirect_to(root_path)
  end
end
