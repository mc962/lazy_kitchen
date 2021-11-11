require "test_helper"

class Manage::Legacy::StepIngredientsControllerTest < ApplicationControllerTestCase
  context 'unauthenticated user' do
    setup do
      @step_ingredient = FactoryBot.create(:step_ingredient)
    end

    should"show step ingredient" do
      get manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :found
    end

    should"new step ingredient" do
      get new_manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :unauthorized
    end

    should"create step ingredient" do
      post manage_legacy_recipe_step_step_ingredients_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient), params: {}
      assert_response :unauthorized
    end

    should"edit step ingredient" do
      get edit_manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :found
    end

    should"update step ingredient" do
      patch manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :found
    end

    should"destroy step ingredient" do
      delete manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :found
    end
  end

  context 'authenticated user' do
    setup do
      @step_ingredient = FactoryBot.create(:step_ingredient)
      @user = @step_ingredient.step.recipe.user
      sign_in @user
    end

    should"get show" do
      get manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :success
    end

    should"get new" do
      get new_manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id)
      assert_response :success
    end

    should"create step ingredient" do
      new_step_ingredient_params = {
        amount: Faker::Number.between(from: 1, to: 10),
        condition: Faker::Adjective.positive + SecureRandom.uuid,  # Attempt to make query later that will be unique
        unit: Faker::Food.metric_measurement,
        ingredient: {
          name: Faker::Food.unique.ingredient,
          description: Faker::Food.description
        }
      }

      post manage_legacy_recipe_step_step_ingredients_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id),
           params: {step_ingredient: new_step_ingredient_params}
      assert_response :found

      created_step_ingredient = StepIngredient.managed.where(
        amount: new_step_ingredient_params[:amount],
        condition: new_step_ingredient_params[:condition],
        unit: new_step_ingredient_params[:unit]
      )
      assert_redirected_to manage_legacy_recipe_step_step_ingredient_url(
                             created_step_ingredient.step.recipe.id,
                             created_step_ingredient.step.id,
                             created_step_ingredient
                           )
    end

    should"get edit" do
      get edit_manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :success
    end

    should"update step ingredient" do
      update_step_ingredient_params = @step_ingredient.attributes
      update_step_ingredient_params[:condition] = Faker::Adjective.positive + SecureRandom.uuid
      update_step_ingredient_params[:ingredient] = {
        name: @step_ingredient.ingredient.name + SecureRandom.uuid
      }
      patch manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient), params: {step_ingredient: update_step_ingredient_params}
      assert_response :found
      assert_redirected_to manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
    end

    should"destroy step ingredient" do
      delete manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :found
      assert_redirected_to manage_legacy_recipe_step_path(@step_ingredient.step.recipe.id, @step_ingredient.step)
    end
  end

end
