class Admin::DashboardController < ApplicationController
    before_action :set_user, only: %i[show edit update]

    def index
        @users = User.where(role: :trader)
        @pending_traders = User.where(role: :trader, status: 'pending')
    end

    def new
        @user = User.new(role: :trader)
    end

    def create
        @user = User.new(trader_params)
        if @user.save
            redirect_to admin_dashboard_index_path, notice: 'Trader was created successfully.'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update(trader_params.except(:id, :password, :password_confirmation))
            redirect_to admin_dashboard_index_path, notice: 'Trader info updated successfully.'
        else
            render :edit
        end
    end

    def show
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def trader_params
        params.require(:user).permit(:status, :first_name, :last_name, :email, :password, :password_confirmation, :role)
    end
      
end
