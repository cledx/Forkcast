class ShoppingItemsController < ApplicationController
  def index
    @week = Week.find(params[:week_id])
    @shopping_items = @week.shopping_items.all
  end

  def update
    @week = Week.find(params[:week_id])
    @shopping_items = @week.shopping_items.find(params[:id])
    @shopping_item.update
    if @shopping_item.save
      redirect_to shopping_items
    else
      render :index, status: :unprocessable_entity
    end
  end
end
