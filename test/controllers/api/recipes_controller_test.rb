require "test_helper"

class API::RecipesControllerTest < ApplicationControllerTestCase
  context 'not logged in' do
    should 'recipes list may not be accessed' do
      get api_recipes_url
      assert_redirected_to new_user_session_path
    end

    should 'individual recipe may not be accessed' do
      get api_recipe_url(subject)
      assert_redirected_to new_user_session_path
    end
  end

  context 'logged in' do
    setup do
      @recipe = FactoryBot.create(:recipe_with_user)
      sign_in @recipe.user
    end

    should 'recipes list may be accessed' do
      get api_recipes_url
      assert_response :success
    end

    should 'individual recipe may be accessed' do
      get api_recipe_url @recipe
      assert_response :success
    end
  end
end
