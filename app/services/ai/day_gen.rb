class Ai::DayGenerator
    def initialize(week, date)
      @week = week
      @date = date
    end

    def generate_day
        @day = Day.new({
            date: @date,
            week: @week
        })
        # This gets the day template for the user's day of the week.
        day_template = @week.user.day_template.find_by(day_name: @date.strftime("%A"))
        [day_template.breakfast, day_template.lunch, day_template.dinner].each do |dish_num|
            if dish_num.present?
                dish = Dish.new({
                    day: @day,
                    # This sends the dish number to the recipe generator to generate the recipe.
                    recipe: Ai::RecipeGenerator.new(dish_num).generate_recipe,
                    category: dish_num.category
                })
                dish.save
            end
        end
        @day.save
    end
end