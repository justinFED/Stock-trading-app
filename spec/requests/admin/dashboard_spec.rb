require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @admin_user = create(:admin_user)
    sign_in @admin_user
  end

  describe 'GET #index' do
   it 'renders the index template and assigns @users with traders' do
    trader = create(:user, role: 'trader')
    get admin_dashboard_index_path
    expect(response).to render_template :index
    expect(assigns(:users)).to eq([trader])
   end
  end

  describe 'GET #new' do
   it 'renders the new template' do
    get new_admin_dashboard_path
    expect(response).to render_template :new
   end
  end

end
