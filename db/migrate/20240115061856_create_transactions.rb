class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stock_symbol
      t.integer :quantity
      t.decimal :price
      t.string :transaction_type

      t.timestamps
    end
  end
end
