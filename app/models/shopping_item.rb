class ShoppingItem < ApplicationRecord
  belongs_to :ingredient
  belongs_to :week
end
