require 'rails_helper'

RSpec.describe "User::Users", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/user/users/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/user/users/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /exit" do
    it "returns http success" do
      get "/user/users/exit"
      expect(response).to have_http_status(:success)
    end
  end

end
