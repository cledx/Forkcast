class CreateWeeks < ActiveRecord::Migration[8.1]
  def change
    create_table :weeks do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :month

      t.timestamps
    end
  end
end
