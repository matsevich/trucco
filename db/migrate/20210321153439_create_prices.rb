class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.monetize :buy_price, null: true
      t.monetize :sell_price, null: true
      t.integer :quantity

      t.timestamps

      t.index :sell_price_cents
    end
  end
end
