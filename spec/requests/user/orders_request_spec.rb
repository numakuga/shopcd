require 'rails_helper'

RSpec.describe "User::Orders", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/user/orders/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/user/orders/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /thanks" do
    it "returns http success" do
      get "/user/orders/thanks"
      expect(response).to have_http_status(:success)
    end
  end

end
