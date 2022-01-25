require "test_helper"

class Manage::Stable::StepsControllerTest < ApplicationControllerTestCase
  context 'unauthenticated user' do
    setup do
      @step = FactoryBot.create(:step)
    end

    should"show step" do
      get manage_legacy_recipe_step_url(@step.recipe, @step)
      assert_response :found
    end

    should"new step" do
      get new_manage_legacy_recipe_step_url(@step.recipe)
      assert_response :found
    end

    should"create step" do
      post manage_legacy_recipe_steps_url(@step.recipe), params: {}
      assert_response :found
    end

    should"edit step" do
      get edit_manage_legacy_recipe_step_url(@step.recipe, @step)
      assert_response :found
    end

    should"update step" do
      patch manage_legacy_recipe_step_url(@step.recipe, @step)
      assert_response :found
    end

    should"destroy step" do
      delete manage_legacy_recipe_step_url(@step.recipe, @step)
      assert_response :found
    end
  end

  context 'authenticated user' do
    setup do
      @step = FactoryBot.create(:step)
      @user = @step.recipe.user
      sign_in @user
    end

    should"get show" do
      get manage_legacy_recipe_step_url(@step.recipe.id, @step)
      assert_response :success
    end

    should"get new" do
      get new_manage_legacy_recipe_step_url(@step.recipe.id)
      assert_response :success
    end

    should"create step" do
      new_step_params = {order: Faker::Number.between(from: 1, to: 100), instruction: Faker::TvShows::DrWho.quote + SecureRandom.uuid}
      post manage_legacy_recipe_steps_url(@step.recipe.id), params: {step: new_step_params}
      assert_response :found

      created_step = Step.includes(:recipe).find_by(instruction: new_step_params[:instruction])
      assert_redirected_to manage_legacy_recipe_step_url(created_step.recipe.id, created_step)
    end

    should"get edit" do
      get edit_manage_legacy_recipe_step_url(@step.recipe.id, @step)
      assert_response :success
    end

    should"update step" do
      update_step_params = @step.attributes
      update_step_params[:instruction] = Faker::Movies::LordOfTheRings.quote
      update_step_params[:recipe_id] = @step.recipe.id
      patch manage_legacy_recipe_step_url(@step.recipe.id, @step), params: {step: update_step_params}
      assert_response :found
      assert_redirected_to manage_legacy_recipe_step_url(@step.recipe.id, @step)
    end

    should"destroy step" do
      delete manage_legacy_recipe_step_url(@step.recipe.id, @step)
      assert_response :found
      assert_redirected_to manage_legacy_recipe_url(@step.recipe.id)
    end
  end

  context 'cannot access unauthorized resources' do
    setup do
      @authorized_step = FactoryBot.create(:step)
      @authorized_user = @authorized_step.recipe.user

      @unauthorized_step = FactoryBot.create(:step)
      @unauthorized_user = @unauthorized_step.recipe.user

      sign_in @unauthorized_user
    end

    should"get show" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user step recipes

      assert_raises ActionPolicy::Unauthorized do
        get manage_legacy_recipe_step_url(@authorized_step.recipe.id, @authorized_step)
      end
    end

    should"get new" do
      # NOTE: Currently new is allowed by everyone, as it just gets the a page to make a new step

      get new_manage_legacy_recipe_step_url(@authorized_step.recipe.id)
      assert_response :success
    end

    should"create step" do
      # NOTE: Expected to fail, as user should not be able to add step to recipe they do not own
      new_step_params = {order: Faker::Number.between(from: 1, to: 100), instruction: Faker::TvShows::DrWho.quote}
      assert_raises ActionPolicy::Unauthorized do
        post manage_legacy_recipe_steps_url(@authorized_step.recipe.id), params: {step: new_step_params}
      end
    end

    should"get edit" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user step recipes

      assert_raises ActionPolicy::Unauthorized do
        get edit_manage_legacy_recipe_step_url(@authorized_step.recipe.id, @authorized_step)
      end
    end

    should"update step" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed update @authorized_user_recipes

      assert_raises ActionPolicy::Unauthorized do
        update_step_params = @authorized_step.attributes
        update_step_params[:instruction] = Faker::Movies::LordOfTheRings.quote
        update_step_params[:recipe_id] = @authorized_step.recipe.id
        patch manage_legacy_recipe_step_url(@authorized_step.recipe.id, @authorized_step), params: {step: update_step_params}
      end
    end

    should "destroy step" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user recipes

      assert_raises ActionPolicy::Unauthorized do
        delete manage_legacy_recipe_step_url(@authorized_step.recipe.id, @authorized_step)
      end
    end
  end
end
