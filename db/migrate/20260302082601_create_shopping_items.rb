class CreateShoppingItems < ActiveRecord::Migration[8.1]
  def change
    create_table :shopping_items do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :week, null: false, foreign_key: true
      t.float :total
      t.boolean :purchased
      t.string :unit

      t.timestamps
    end
  end
end
