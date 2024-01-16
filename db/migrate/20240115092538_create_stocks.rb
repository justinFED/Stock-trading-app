class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :company_name
      t.string :symbol
      t.decimal :latest_price

      t.timestamps
    end
  end
end
