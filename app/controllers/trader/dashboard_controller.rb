class Trader::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @stock_symbol = params[:symbol] || 'AAPL'
    @quote = fetch_stock_quote(@stock_symbol)
  end

  def show
    @stock_symbol = params[:symbol]

    begin
      @quote = IEX::Resources::Quote.get(@stock_symbol)
    rescue IEX::Errors::ClientError => e
      flash[:alert] = "Error fetching stock quote for #{@stock_symbol}: #{e.message}"
      redirect_to trader_dashboard_index_path(symbol: @stock_symbol)
    end
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
