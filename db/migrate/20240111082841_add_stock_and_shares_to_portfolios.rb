class AddStockAndSharesToPortfolios < ActiveRecord::Migration[7.1]
  def change
    add_column :portfolios, :stock, :string
    add_column :portfolios, :shares, :integer
  end
end
