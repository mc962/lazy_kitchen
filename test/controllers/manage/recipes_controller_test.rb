require "test_helper"

class Manage::RecipesControllerTest < ApplicationControllerTestCase
  context 'unauthenticated user' do
    setup do
      @user = FactoryBot.create(:user_with_recipes)
    end

    should"get index" do
      get manage_recipes_url
      assert_response :found
    end

    should"get show" do
      get manage_recipe_url(@user.recipes.first)
      assert_response :found
    end

    should"get new" do
      get new_manage_recipe_url
      assert_response :found
    end

    should"get create" do
      post manage_recipes_url, params: {}
      assert_response :found
    end

    should"get edit" do
      get edit_manage_recipe_url(@user.recipes.first)
      assert_response :found
    end

    should"get update" do
      patch manage_recipe_url(@user.recipes.first)
      assert_response :found
    end

    should"get destroy" do
      delete manage_recipe_url(@user.recipes.first)
      assert_response :found
    end
  end

  context 'authenticated user' do
    setup do
      @user = FactoryBot.create(:user_with_recipes)
      sign_in @user
    end

    should"get index" do
      get manage_recipes_url
      assert_response :success
    end

    should"get show" do
      get manage_recipe_url(@user.recipes.first)
      assert_response :success
    end

    should"get new" do
      get new_manage_recipe_url
      assert_response :success
    end

    should"create recipe" do
      new_recipe_params = {name: "#{Faker::Food.name}-#{SecureRandom.uuid}"}
      post manage_recipes_url, params: {recipe: new_recipe_params}
      assert_response :found
      assert_redirected_to manage_recipe_url(Recipe.find_by(name: new_recipe_params[:name]))
    end

    should"get edit" do
      get edit_manage_recipe_url(@user.recipes.first)
      assert_response :success
    end

    should"update recipe" do
      update_recipe = @user.recipes.first
      update_recipe_params = @user.recipes.first.attributes
      update_recipe_params[:name] = "#{Faker::Food.name}-#{SecureRandom.uuid}"
      patch manage_recipe_url(update_recipe), params: {recipe: update_recipe_params}
      assert_response :found
      assert_redirected_to manage_recipe_url(Recipe.find_by(name: update_recipe_params[:name]))
    end

    should"destroy recipe" do
      delete manage_recipe_url(@user.recipes.first)
      assert_response :found
      assert_redirected_to manage_recipes_url
    end
  end

  context 'cannot access unauthorized resources' do
    setup do
      @authorized_user = FactoryBot.create(:user_with_recipes)
      @unauthorized_user = FactoryBot.create(:user)

      sign_in @unauthorized_user
    end

    should"get index" do
      # NOTE: Currently index is allowed by everyone, as it just gets the current user's recipes

      get manage_recipes_url
      assert_response :success
    end

    should"get show" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user recipes

      assert_raises ActionPolicy::Unauthorized do
        get manage_recipe_url(@authorized_user.recipes.first)
      end
    end

    should"get new" do
      # NOTE: Currently new is allowed by everyone, as it just gets the a page to make a new recipe

      get new_manage_recipe_url
      assert_response :success
    end

    should"create recipe" do
      # NOTE: As user_id is not a whitelisted attribute, a user cannot supply a different user_id to add a Recipe to the user.
      #   In any case, the Recipe is manually associated with current_user anyway, so the Recipe may only be added to the logged-in
      #   user, and so this test is not currently expected to fail authorization checks.

      new_recipe_params = {name: "#{Faker::Food.name}-#{SecureRandom.uuid}", user_id: @authorized_user.id}
      post manage_recipes_url, params: {recipe: new_recipe_params}
      assert_response :found
      assert_redirected_to manage_recipe_url(Recipe.find_by(name: new_recipe_params[:name]))
    end

    should"get edit" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user recipes

      assert_raises ActionPolicy::Unauthorized do
        get edit_manage_recipe_url(@authorized_user.recipes.first)
      end
    end

    should"update recipe" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed update @authorized_user_recipes

      assert_raises ActionPolicy::Unauthorized do
        update_recipe = @authorized_user.recipes.first
        update_recipe_params = @authorized_user.recipes.first.attributes
        update_recipe_params[:name] = "#{Faker::Food.name}-#{SecureRandom.uuid}"
        patch manage_recipe_url(update_recipe), params: {recipe: update_recipe_params}
      end
    end

    should"destroy recipe" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user recipes

      assert_raises ActionPolicy::Unauthorized do
        delete manage_recipe_url(@authorized_user.recipes.first)
      end
    end
  end
end
