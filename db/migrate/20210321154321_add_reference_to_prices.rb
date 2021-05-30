class AddReferenceToPrices < ActiveRecord::Migration[6.0]
  def change
    add_reference :prices, :product, foreign_key: true
  end
end
