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

    should "get show" do
      get manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :success
    end

    should "get new" do
      get new_manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id)
      assert_response :success
    end

    should "create step ingredient" do
      new_step_ingredient_params = {
        amount: Faker::Number.between(from: 1, to: 10),
        condition: Faker::Adjective.positive + SecureRandom.uuid,  # Attempt to make query later that will be unique
        unit: Faker::Food.metric_measurement,
        ingredient_attributes: {
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
      ).first
      assert_redirected_to manage_legacy_recipe_step_step_ingredient_url(
                             created_step_ingredient.step.recipe.id,
                             created_step_ingredient.step.id,
                             created_step_ingredient
                           )
    end

    should "get edit" do
      get edit_manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :success
    end

    should "update step ingredient" do
      update_step_ingredient_params = @step_ingredient.attributes
      update_step_ingredient_params[:amount] = Faker::Number.between(from: 1, to: 10)
      update_step_ingredient_params[:condition] = Faker::Adjective.positive + SecureRandom.uuid  # Attempt to make query later that will be unique
      update_step_ingredient_params[:unit] = Faker::Food.metric_measurement
      update_step_ingredient_params[:ingredient_attributes] = {
        name: Faker::Food.unique.ingredient,
        description: Faker::Food.description
      }

      patch manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient),
            params: {step_ingredient: update_step_ingredient_params}
      assert_response :success

      # assert_redirected_to manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
    end

    should "destroy step ingredient" do
      delete manage_legacy_recipe_step_step_ingredient_url(@step_ingredient.step.recipe.id, @step_ingredient.step.id, @step_ingredient)
      assert_response :found
      assert_redirected_to manage_legacy_recipe_step_path(@step_ingredient.step.recipe.id, @step_ingredient.step)
    end
  end

  context 'cannot access unauthorized resources' do
    setup do
      # @authorized_author = FactoryBot.create(:author)
      #       @authorized_user = @authorized_author.citation.recipe.user
      #
      #       @unauthorized_author = FactoryBot.create(:author)
      #       @unauthorized_user = @unauthorized_author.citation.recipe.user
      #
      #       sign_in @unauthorized_user

      @authorized_step_ingredient = FactoryBot.create(:step_ingredient)
      @authorized_user = @authorized_step_ingredient.step.recipe.user

      @unauthorized_step_ingredient = FactoryBot.create(:step_ingredient)
      @unauthorized_user = @unauthorized_step_ingredient.step.recipe.user

      sign_in @unauthorized_user
    end

    should "get show" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user author recipes

      assert_raises ActionPolicy::Unauthorized do
        get manage_legacy_recipe_step_step_ingredient_url(@authorized_step_ingredient.step.recipe.id, @authorized_step_ingredient.step.id, @authorized_step_ingredient)
      end
    end

    should "get new" do
      # NOTE: Currently new is allowed by everyone, as it just gets the a page to make a new author

      get new_manage_legacy_recipe_step_step_ingredient_url(@authorized_step_ingredient.step.recipe.id, @authorized_step_ingredient.step.id, @authorized_step_ingredient)
      assert_response :success
    end

    should "create step ingredient" do
      new_step_ingredient_params = {
        amount: Faker::Number.between(from: 1, to: 10),
        condition: Faker::Adjective.positive + SecureRandom.uuid,  # Attempt to make query later that will be unique
        unit: Faker::Food.metric_measurement,
        ingredient_attributes: {
          name: Faker::Food.unique.ingredient,
          description: Faker::Food.description
        }
      }

      assert_raises ActionPolicy::Unauthorized do
        post manage_legacy_recipe_step_step_ingredients_url(@authorized_step_ingredient.step.recipe.id, @authorized_step_ingredient.step.id),
             params: {step_ingredient: new_step_ingredient_params}
      end
    end

    should "get edit" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user author recipes

      assert_raises ActionPolicy::Unauthorized do
        get edit_manage_legacy_recipe_step_step_ingredient_url(@authorized_step_ingredient.step.recipe.id, @authorized_step_ingredient.step.id, @authorized_step_ingredient)
      end
    end

    should "update step ingredient" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed update @authorized_user_recipes

      assert_raises ActionPolicy::Unauthorized do
        update_step_ingredient_params = @authorized_step_ingredient.attributes
        update_step_ingredient_params[:amount] = Faker::Number.between(from: 1, to: 10)
        update_step_ingredient_params[:condition] = Faker::Adjective.positive + SecureRandom.uuid  # Attempt to make query later that will be unique
        update_step_ingredient_params[:unit] = Faker::Food.metric_measurement
        update_step_ingredient_params[:ingredient_attributes] = {
          name: Faker::Food.unique.ingredient,
          description: Faker::Food.description
        }

        patch manage_legacy_recipe_step_step_ingredient_url(@authorized_step_ingredient.step.recipe.id, @authorized_step_ingredient.step.id, @authorized_step_ingredient),
              params: {step_ingredient: update_step_ingredient_params}
      end
    end

    should "destroy step ingredient" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user recipes

      assert_raises ActionPolicy::Unauthorized do
        delete manage_legacy_recipe_step_step_ingredient_url(@authorized_step_ingredient.step.recipe.id, @authorized_step_ingredient.step.id, @authorized_step_ingredient)
      end
    end
  end
end
