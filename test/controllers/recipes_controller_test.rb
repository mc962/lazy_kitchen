require "test_helper"

class RecipesControllerTest < ApplicationControllerTestCase
  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should get show" do
    recipe = FactoryBot.create(:recipe_with_user, publicly_accessible: true)

    get recipe_url(recipe)
    assert_response :success
  end
end
