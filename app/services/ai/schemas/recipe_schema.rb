class Ai::Schemas::RecipeSchema < RubyLLM::Schema
  schema do
    field :name,        type: :string, desc: "The name of the recipe"
    field :description, type: :string, desc: "A description of the recipe"
    field :cuisine,     type: :string, desc: "Cuisine type (e.g., Italian, Chinese, Mexican)"
    field :servings,    type: :integer, desc: "Number of servings this recipe makes"

    field :ingredients, type: :array, desc: "The list of ingredients for the recipe" do
      item type: :object do
        field :name,            type: :string, desc: "Name of the ingredient"
        field :quantity_value,  type: :string, desc: "Numeric quantity (e.g., 2, 1.5, 1/2)"
        field :quantity_unit,   type: :string, desc: "Unit of measure (e.g., cups, tbsp, kg, g, ml, pinch)"
      end
    end

    field :instructions, type: :array, desc: "Step-by-step instructions for making the recipe" do
      item type: :string, desc: "A single step instruction"
    end

    field :prep_time_minutes, type: :integer, desc: "Preparation time in minutes"
    field :cook_time_minutes, type: :integer, desc: "Cooking time in minutes"
    field :dietary_restrictions, type: :array, desc: "List of dietary restriction tags (e.g., vegan, gluten-free)" do
      item type: :string
    end
  end
end