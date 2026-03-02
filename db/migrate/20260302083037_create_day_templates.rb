class CreateDayTemplates < ActiveRecord::Migration[8.1]
  def change
    create_table :day_templates do |t|
      t.references :user, null: false, foreign_key: true
      t.string :day_name
      t.integer :breakfast
      t.integer :lunch
      t.integer :dinner

      t.timestamps
    end
  end
end
