class Admin::DashboardController < ApplicationController
    before_action :set_user, only: %i[show edit update]

    def index
        @users = User.where(role: :trader)
        @pending_traders = User.where(role: :trader, status: 'pending')
        @stock_prices = fetch_stock_prices(['AAPL', 'GOOGL', 'MSFT', 'AMZN', 'TSLA'])
        @market_news = fetch_market_news
    end

    def pending_sign_ups
        @pending_traders = User.where(role: :trader, status: 'pending')
    end

    def all_users
        @admins = User.where(role: :admin)
        @approved_traders = User.where(role: :trader, status: 'approved')
    end
    

    def new
        @user = User.new(role: :trader)
    end
  
    def create
        @user = User.new(trader_params)
        if @user.save
            if @user.status == 'approved'
                UserMailer.approved_email(@user).deliver_later
            end
            redirect_to admin_dashboard_index_path, notice: 'Trader was created successfully.'
        else
            render :new, status: :unprocessable_entity
        end
    end
      

    def edit
    end

    def update
        if @user.update(trader_params.except(:id, :password, :password_confirmation))
          if @user.saved_change_to_status?
            if @user.status == 'approved'
              UserMailer.approved_email(@user).deliver_later
            end
          end
          redirect_to admin_dashboard_path(@user), notice: 'Trader info updated successfully.'
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

    def fetch_stock_prices(symbols)
        begin
          client = IEX::Api::Client.new
          stock_prices = symbols.map { |symbol| client.quote(symbol) }
          stock_prices
        rescue IEX::Errors::ClientError => e
          flash[:alert] = "Error fetching stock prices: #{e.message}"
          Rails.logger.error("Error fetching stock prices: #{e.message}")
          []
        end
      end

      def fetch_market_news
        begin
          client = IEX::Api::Client.new
          symbols = ['TSLA', 'GOOGL', 'AMZN']
          news = []
      
          symbols.each do |symbol|
            symbol_news = client.news(symbol).take(1)
            news.concat(symbol_news)
          end
      
          Rails.logger.debug("Market News: #{news.inspect}")
          news || [] 
        rescue IEX::Errors::ClientError => e
          flash[:alert] = "Error fetching market news: #{e.message}"
          Rails.logger.error("Error fetching market news: #{e.message}")
          []
        end
      end
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
end
