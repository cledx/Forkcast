class DishJob < ApplicationJob
    queue_as :default

    def perform(dish_id, new_id)
        dish = Dish.find(dish_id)
        if new_id == "regenerate"
            @new_dish = Ai::DishGen.new(@dish.day, @dish.portions, @dish.category).generate_dish
            @dish.update(recipe_id: @new_dish.recipe_id, category: @new_dish.category)
            @new_dish.destroy
        elsif new_id.present?
            @new_dish = Recipe.find(new_id)
            @dish.update(recipe_id: @new_dish.id)
        end
    end
end