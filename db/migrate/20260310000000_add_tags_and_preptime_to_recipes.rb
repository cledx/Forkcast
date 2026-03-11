class AddTagsAndPreptimeToRecipes < ActiveRecord::Migration[8.1]
  def change
    add_column :recipes, :tags, :string, array: true
    add_column :recipes, :preptime, :integer
  end
end

