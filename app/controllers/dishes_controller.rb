class DishesController < ApplicationController
  def show
    @dish = Dish.find(params[:id])
    @recipe = @dish.recipe
    redirect_to recipe_path(@recipe)
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update(dish_params)
      redirect_to week_day_path(@dish.day)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:recipe_id, :amount, :category)
  end
end
