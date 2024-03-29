require 'rails_helper'

RSpec.describe "Admin::Artists", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/admin/artists/index"
      expect(response).to have_http_status(:success)
    end
  end

end
