require 'rails_helper'

RSpec.describe "User::CartItems", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/user/cart_items/index"
      expect(response).to have_http_status(:success)
    end
  end

end
