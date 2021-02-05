class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price_cents
      t.timestamps

      t.index :name
      t.index :price_cents
    end
  end
end
