class CreateRecipes < ActiveRecord::Migration[8.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :cooktime
      t.text :instructions
      t.string :cuisine

      t.timestamps
    end
  end
end
