class Trader::DashboardController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @user = current_user
      default_stock_symbol = 'AAPL'
      @quote = fetch_stock_quote(default_stock_symbol)
    end
  
    def show
      @stock_symbol = params[:symbol]
  
      begin
        @quote = IEX::Resources::Quote.get(@stock_symbol)
      rescue IEX::Errors::ClientError => e
        flash[:alert] = "Error fetching stock quote for #{@stock_symbol}: #{e.message}"
        redirect_to trader_dashboard_index_path
      end
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
  
    private
  
    def fetch_stock_quote(symbol)
        begin
          client = IEX::Api::Client.new
          @quote = client.quote(symbol)
          Rails.logger.debug("Stock Quote: #{@quote}")
          @quote
        rescue IEX::Errors::ClientError => e
          flash[:alert] = "Error fetching stock quote for #{symbol}: #{e.message}"
          Rails.logger.error("Error fetching stock quote for #{symbol}: #{e.message}")
          nil
        end
      end
      
  end
  