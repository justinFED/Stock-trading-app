class Trader::PortfoliosController < ApplicationController
  def index
    @portfolios = []
    @total = 0

    current_user.portfolios.each do |portfolio|
      stock = IEX::Api::Client.new.quote(portfolio.stock)
      total = stock.latest_price * portfolio.shares
      @total += total

      @portfolios.push({
        stock: portfolio.stock,
        current_price: stock.latest_price,
        total: total,
        shares: portfolio.shares
      })
    end
  end
end
