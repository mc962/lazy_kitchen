require "test_helper"

class Manage::StepsControllerTest < ApplicationControllerTestCase
  context 'unauthenticated user' do
    setup do
      @step = FactoryBot.create(:step)
    end

    should"update step" do
      patch manage_recipe_step_url(@step.recipe, @step)
      assert_response :found
    end
  end

  context 'authenticated user' do
    setup do
      @step = FactoryBot.create(:step)
      @user = @step.recipe.user
      sign_in @user
    end

    should"update step" do
      update_step_params = @step.attributes
      update_step_params[:instruction] = Faker::Movies::LordOfTheRings.quote
      update_step_params[:recipe_id] = @step.recipe.id
      patch manage_recipe_step_url(@step.recipe.id, @step), params: {step: update_step_params}
      assert_response :found
      assert_redirected_to edit_manage_recipe_url(@step.recipe, tab: 'steps')
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

    should"update step" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed update @authorized_user_recipes

      assert_raises ActionPolicy::Unauthorized do
        update_step_params = @authorized_step.attributes
        update_step_params[:instruction] = Faker::Movies::LordOfTheRings.quote
        update_step_params[:recipe_id] = @authorized_step.recipe.id
        patch manage_recipe_step_url(@authorized_step.recipe.id, @authorized_step), params: {step: update_step_params}
      end
    end
  end
end
