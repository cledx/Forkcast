class AddColumnsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :username, :string
    add_column :users, :allergies, :string, array: true
    add_column :users, :preferred_ingredients, :string, array: true
    add_column :users, :undesireable_ingredients, :string, array: true
    add_column :users, :disease, :string, array: true
    add_column :users, :preferred_cuisines, :string, array: true
  end
end
