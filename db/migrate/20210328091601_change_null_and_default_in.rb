class ChangeNullAndDefaultIn < ActiveRecord::Migration[6.0]
  def change
    change_column_null :prices, :buy_price_cents, from: false, to: true
    change_column_null :prices, :sell_price_cents, from: false, to: true
    change_column_default :prices, :buy_price_cents, from: 0, to: nil
    change_column_default :prices, :sell_price_cents, from: 0, to: nil
  end
end
