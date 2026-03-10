class Ai::DishGen

  def initialize(day, meal_name)
      @day = day
      @portions = portions
      @meal_name = meal_name
  end

    def generate_dish
        @rubyllm = RubyLLM.chat
        .with_tool(SearchIngredientsTool)
        .with_tool(SearchRecipesTool)
        .with_instructions(prompt_gen)
        .with_schema(Ai::Schemas::DishSchema.new("DishSchema"))
        # Generate the previous week's meals text.
        previous_meals = previous_week_meals_text(@day.week.user, @day.date)
        # Generate the current week's meals text.
        current_week_meals = @day.week.dishes.map { |dish| "#{dish.day.date.strftime('%A')}: #{dish.category}: #{dish.recipe.name}"}.join("\n")
        # Generate the response from the AI.
        response = @rubyllm.ask("The client's previous weeks meals were: #{previous_meals}. You need to generate a meal for #{@day.date.strftime('%A')} for #{@meal_name}. This weeks meals so far are: #{current_week_meals}.")
        # If the recipe ID is "Generate new Recipe", then create a new recipe.
        if response.content["recipe_id"] == "Generate new Recipe"
          new_recipe = Ai::RecipeGen.new(response.content["recipe_data"]["cuisine"], response.content["recipe_data"]["main_ingredient"]).generate_recipe
          dish = Dish.create(day: @day, recipe_id: new_recipe.id, category: @meal_name, portions: @portions)
        else
          dish = Dish.create(day: @day, recipe_id: response.content["recipe_id"], category: @meal_name, portions: @portions)
        end
        dish
    end

    private

    def previous_week_meals_text(user, reference_date)
      dishes = user.previous_week_dishes(reference_date)
      return "None." if dishes.empty?
      # Group the dishes by date and sort them by date.
      dishes
        .group_by { |d| d.day.date.to_date }
        .sort_by { |date, _| date }
        .map do |date, day_dishes|
          meals = day_dishes.sort_by(&:category).map { |d| "#{d.category}: #{d.recipe.name}" }.join("; ")
          "#{date.strftime('%A')}: #{meals}"
        end
        .join("\n")
    end

    private

    def prompt_gen
      prompt = <<-PROMPT
      You are a meal cooridnator. 
      The user is a busy person who need help with planning their meals to prep for the week. 
      You need to plan a few meals for them to cook in advance to feed them for the week. 
      Select from the following recipes and pick the best ones for the user.
      PROMPT
    end

    def recipe_filter
      # Return only recipes that do NOT contain any of the tags in @user.disease
      recipes = Recipe.all.select do |recipe|
        Array(@user.disease).none? { |tag| recipe.tags.include?(tag) }
      end
    end

end
    