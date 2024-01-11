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

  describe 'POST #create' do
    context 'with valid parameters' do 
      it 'creates a new trader and redirects to admin dashboard index' do
        trader_params = attributes_for(:user, role: 'trader')
        expect {
          post '/admin/dashboard', params: { user: trader_params }
        }.to change(User, :count).by(1)

        expect(response).to redirect_to('/admin/dashboard')
      end
    end

    context 'with invalid parameters' do
      it 'renders the new template' do
        invalid_params = attributes_for(:user, role: 'trader', email: nil)
        
        expect {
          post '/admin/dashboard', params: { user: invalid_params }
        }.not_to change(User, :count)

        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
   it 'renders the edit template' do
    trader = create(:user, role: 'trader')
    get edit_admin_dashboard_path(trader)
    expect(response).to render_template :edit
   end
  end

  describe 'PATCH #update' do
  let(:trader) { create(:user, role: 'trader') }

  context 'with valid parameters' do
    it 'updates trader info and redirects to admin dashboard' do
      updated_params = attributes_for(:user, first_name: 'Updated Name')
      patch "/admin/dashboard/#{trader.id}", params: { user: updated_params }
      trader.reload
      expect(trader.first_name).to eq('Updated Name')
      expect(response).to redirect_to(admin_dashboard_path)
    end
  end

  context 'with invalid parameters' do
    it 'renders the edit template' do
      invalid_params = attributes_for(:user, email: nil)
      patch "/admin/dashboard/#{trader.id}", params: { user: invalid_params }
      expect(response).to render_template :edit
    end
  end
end

describe 'GET #show' do
  it 'renders the show template' do
    trader = create(:user, role: 'trader')
    get "/admin/dashboard/#{trader.id}"
    expect(response).to render_template :show
  end
end

end
