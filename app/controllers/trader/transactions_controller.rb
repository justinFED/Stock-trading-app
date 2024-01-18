class Trader::TransactionsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @user = current_user
      @transactions = @user.transactions
    end
  
    def new
      @transaction = current_user.transactions.new(transaction_params)
    end
  
    def create
      @transaction = current_user.transactions.new(transaction_params)
      if @transaction.save
          redirect_to trader_transactions_path, notice: "Transaction successful."
          update_user_balance
      else
        flash.now[:alert] = "Transaction cannot proceed."
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def transaction_params
      params.require(:transaction).permit(:stock_symbol, :quantity, :price, :transaction_type, :user_id)
    end
  
    def update_user_balance
      if @transaction.buy?
        current_user.update(balance: current_user.balance - @transaction.total_cost)
      elsif @transaction.sell?
        current_user.update(balance: current_user.balance + @transaction.total_cost)
      end
    end
end
