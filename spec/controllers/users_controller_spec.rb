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
    # require 'pry'; binding.pry
    # expect(response).to have_tag(".notification.is-success", I18n.t("users.create.welcome", name: "John"))
  end
end
