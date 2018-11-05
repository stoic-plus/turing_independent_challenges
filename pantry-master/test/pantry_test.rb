require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new

    @r0 = Recipe.new("Cheese Pizza")
    @r0.add_ingredient("Cheese", 20)
    @r0.add_ingredient("Flour", 20)

    @r1 = Recipe.new("Spaghetti")
    @r1.add_ingredient("Spaghetti Noodles", 10)
    @r1.add_ingredient("Marinara Sauce", 10)
    @r1.add_ingredient("Cheese", 5)

    @r2 = Recipe.new("Pickles")
    @r2.add_ingredient("Brine", 10)
    @r2.add_ingredient("Cucumbers", 30)

    @r3 = Recipe.new("Peanuts")
    @r3.add_ingredient("Raw nuts", 10)
    @r3.add_ingredient("Salt", 10)
  end

  def test_it_has_empty_stock_to_start
    assert_equal ({}), @pantry.stock
  end

  def test_it_returns_0_if_stock_does_have_item
    assert_equal 0, @pantry.stock_check("Cheese")
  end

  def test_it_can_update_stock_of_passed_in_item_with_amount
    assert_equal 0, @pantry.stock_check("Cheese")

    @pantry.restock("Cheese", 10)

    assert_equal 10, @pantry.stock_check("Cheese")
  end

  def test_it_can_check_stock_for_an_item_after_stocking
    @pantry.restock("Cheese", 10)
    @pantry.restock("Cheese", 20)

    assert_equal 30, @pantry.stock_check("Cheese")
  end

  def test_it_can_have_recipe_ingredients_added_to_shopping_list
    assert_equal ({}), @pantry.shopping_list

    @pantry.add_to_shopping_list(@r0)

    expected = {"Cheese" => 20, "Flour" => 20}

    assert_equal expected, @pantry.shopping_list
  end

  def test_it_can_have_multiple_recipes_added_to_list
    assert_equal ({}), @pantry.shopping_list

    @pantry.add_to_shopping_list(@r0)
    @pantry.add_to_shopping_list(@r1)

    expected = {"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}

    assert_equal expected, @pantry.shopping_list
  end
end