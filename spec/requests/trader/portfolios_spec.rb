require 'rails_helper'

RSpec.describe "Trader::Portfolios", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/trader/portfolios/index"
      expect(response).to have_http_status(:success)
    end
  end

end
