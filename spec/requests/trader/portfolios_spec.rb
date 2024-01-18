require 'rails_helper'

RSpec.describe "Trader::Portfolios", type: :request do
  include Devise::Test::IntegrationHelpers

  
  before do
    @approved_trader = create(:approved_trader)
    sign_in @approved_trader
  end
    # pending "add some examples (or delete) #{__FILE__}"

  describe 'GET #index' do
    it 'renders the index template' do
      get trader_portfolios_path
      expect(response).to render_template :index
    end
  end

end
