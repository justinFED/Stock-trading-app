class Admin::TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all

    if params[:search_email].present?
      @transactions = @transactions.joins(:user).where('users.email LIKE ?', "%#{params[:search_email]}%")
    end
    
  end
end
