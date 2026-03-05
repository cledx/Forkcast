require "test_helper"

# I tried to get AI to make a test for the Dish Gen but it failed. I'm not sure why.
# I'm just going to leave it here for now.

module Ai
  # Simple stub used by Ai::DishGenerator when it needs to create a new recipe.
  class RecipeGenerator
    def initialize(recipe_data)
      @recipe_data = recipe_data || {}
    end

    def generate_recipe
      Recipe.create!(
        name: "Generated #{@recipe_data[:main_ingredient] || 'Recipe'}",
        cuisine: @recipe_data[:cuisine] || "TestCuisine",
        cooktime: 900,
        instructions: "Test instructions"
      )
    end
  end
end

class Ai::DishGeneratorTest < ActiveSupport::TestCase
  class FakeChat
    def initialize(response)
      @response = response
    end

    def with_tool(*)
      self
    end

    def with_instruction(*)
      self
    end

    def with_schema(*)
      self
    end

    def ask(*)
      @response
    end
  end

  class FakeLLM
    def initialize(response)
      @chat = FakeChat.new(response)
    end

    def chat
      @chat
    end
  end

  def setup
    @user = User.create!(email: "user@example.com", password: "password")
    @week = Week.create!(user: @user, month: Date.today.month)
    @day  = Day.create!(week: @week, date: Date.today)
  end

  test "generate_dish creates dish for existing recipe" do
    recipe = Recipe.create!(
      name: "Existing",
      cuisine: "TestCuisine",
      cooktime: 600,
      instructions: "Test instructions"
    )

    parsed_response = Struct.new(:recipe_id, :recipe_data)
                            .new(recipe.id.to_s, nil)

    fake_response = "ignored"

    RubyLLM.stub :new, FakeLLM.new(fake_response) do
      JSON.stub :parse, parsed_response do
        generator = Ai::DishGenerator.new(@day, 2, "Dinner")

        assert_difference "Dish.count", +1 do
          @dish = generator.generate_dish
        end
      end
    end

    assert_equal @day, @dish.day
    assert_equal recipe, @dish.recipe
    assert_equal "Dinner", @dish.category
    assert_equal 2, @dish.portions
  end

  test "generate_dish creates dish with new recipe when requested" do
    parsed_response = Struct.new(:recipe_id, :recipe_data)
                            .new(
                              "Generate new Recipe",
                              { cuisine: "Italian", main_ingredient: "Tomato" }
                            )

    fake_response = "ignored"

    RubyLLM.stub :new, FakeLLM.new(fake_response) do
      JSON.stub :parse, parsed_response do
        generator = Ai::DishGenerator.new(@day, 3, "Lunch")

        assert_difference ["Dish.count", "Recipe.count"], +1 do
          @dish = generator.generate_dish
        end
      end
    end

    assert_equal @day, @dish.day
    assert_equal "Lunch", @dish.category
    assert_equal 3, @dish.portions
    assert @dish.recipe.present?
    assert_equal "Italian", @dish.recipe.cuisine
  end
end

