class AddCategoryAssociationToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :category, null: true, foreing_key: true
  end
end
