class Trader::TransactionsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @user = current_user
      @transactions = @user.transactions
    end

    def new
        @transaction = Transaction.new
    end

    def create
        @transaction = current_user.Transaction.new(transaction_params)
        if @transaction.save
            redirect_to trader_transactions_path, notice: "Transaction successful."
        else
            render :new
        end
    end

    private

    def transaction_params
        params.require(:transaction).permit(:stock_symbol, :quantity, :price, :transaction_type)
    end

end
