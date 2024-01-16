class Trader::DashboardController < ApplicationController

    before_action :authenticate_user!
  
    def index
      @user = current_user
      if params[:search].present?
        begin
          @stock = IEX::Api::Client.new.quote(params[:search])
        rescue IEX::Errors::SymbolNotFoundError
          @stock = nil
        end
      end
  
      begin
        @stocks = IEX::Api::Client.new.stock_market_list(:mostactive)
      rescue IEX::Errors::SymbolNotFoundError
        @stocks = []
      end
  
      @transactions = current_user.transactions
    end
  

    def top_up
      @top_up_amount = 0.0
  
      if request.post?
        top_up_amount = params[:top_up_amount].to_f
  
        if top_up_amount > 0
          current_user.top_up_balance(top_up_amount)
          flash[:notice] = "Successfully topped up your balance."
          redirect_to trader_dashboard_index_path
          return
        else
          flash.now[:alert] = "Top-up amount is invalid."
        end
      end
  
      render :top_up
    end

  end
end
