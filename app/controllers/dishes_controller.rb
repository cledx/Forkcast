class DishesController < ApplicationController
  def show
    @dish = Dish.find(params[:id])
  end

  def update
    # This is where we would update the dish, for a given day.
    @dish = Dish.find(params[:id])
    @dish.update(dish_params)
  end

  def show
    # This is where we would show the dish, for a given day. But since we are using the recipe show page for dishes, we will just redirect to the recipe show page.
    @dish = Dish.find(params[:id])
    @recipe = @dish.recipe
    redirect_to recipe_path(@recipe)
  end

  private

  def dish_params
    params.require(:dish).permit(:recipe_id, :day_id, :portions, :category)
  end
end
