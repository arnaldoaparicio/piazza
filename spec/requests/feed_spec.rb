require 'rails_helper'

RSpec.describe "Feeds", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/feed/show"
      expect(response).to have_http_status(:success)
    end
  end

end
