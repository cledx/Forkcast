class ShoppingItemsController < ApplicationController
  def index
    @shopping_items = ShoppingItem.all
  end

  def update
    @shopping_item = ShoppingItem.find(params[:id])
    @shopping_item.update
    if @shopping_item.save
      redirect_to shopping_items
    else
      render :index, status: :unprocessable_entity
    end
  end
end
