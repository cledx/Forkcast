class CreateDishes < ActiveRecord::Migration[8.1]
  def change
    create_table :dishes do |t|
      t.references :day, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.integer :portions
      t.string :category

      t.timestamps
    end
  end
end
