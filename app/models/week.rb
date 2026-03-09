class Week < ApplicationRecord
  has_many :shopping_items
  has_many :days
  has_many :dishes, through: :days
  has_many :recipes, through: :dishes
  has_many :recipe_items, through: :recipes
  has_many :ingredients, through: :shopping_items
  belongs_to :user

  def next_week
    user.weeks.where("id > ?", id).order(:id).first
  end

  def generate_next_week
      7.times do |i|
        day = Day.new(date: (Date.today + 7).beginning_of_week + i.days, week: self).generate_day
        day.save
      end
  end
end
