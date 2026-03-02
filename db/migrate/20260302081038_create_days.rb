class CreateDays < ActiveRecord::Migration[8.1]
  def change
    create_table :days do |t|
      t.references :week, null: false, foreign_key: true
      t.datetime :date

      t.timestamps
    end
  end
end
