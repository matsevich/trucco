class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.text   :description

      t.timestamps
      t.index :title, unique: true
    end
  end
end
