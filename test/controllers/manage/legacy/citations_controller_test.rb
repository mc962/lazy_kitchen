require "test_helper"

class Manage::Legacy::CitationsControllerTest < ApplicationControllerTestCase
  context 'unauthenticated user' do
    setup do
      @citation = FactoryBot.create(:citation)
    end

    should"show citation" do
      get manage_legacy_recipe_citation_url(@citation.recipe, @citation)
      assert_response :found
    end

    should"new citation" do
      get new_manage_legacy_recipe_citation_url(@citation.recipe)
      assert_response :found
    end

    should"create citation" do
      post manage_legacy_recipe_citations_url(@citation.recipe), params: {}
      assert_response :found
    end

    should"edit citation" do
      get edit_manage_legacy_recipe_citation_url(@citation.recipe, @citation)
      assert_response :found
    end

    should"update citation" do
      patch manage_legacy_recipe_citation_url(@citation.recipe, @citation)
      assert_response :found
    end

    should"destroy citation" do
      delete manage_legacy_recipe_citation_url(@citation.recipe, @citation)
      assert_response :found
    end
  end

  context 'authenticated user' do
    setup do
      @citation = FactoryBot.create(:citation)
      @user = @citation.recipe.user
      sign_in @user
    end

    should"get show" do
      get manage_legacy_recipe_citation_url(@citation.recipe.id, @citation)
      assert_response :success
    end

    should"get new" do
      get new_manage_legacy_recipe_citation_url(@citation.recipe.id)
      assert_response :success
    end

    should"create citation" do
      new_citation_params = {content_type: Citation::CONTENT_TYPES.to_a.sample, origin: Citation::ORIGINS.to_a.sample}
      post manage_legacy_recipe_citations_url(@citation.recipe.id), params: {citation: new_citation_params}
      assert_response :found

      created_citation = Citation.last
      assert_redirected_to manage_legacy_recipe_citation_url(created_citation.recipe.id, created_citation)
    end

    should"get edit" do
      get edit_manage_legacy_recipe_citation_url(@citation.recipe.id, @citation)
      assert_response :success
    end

    should"update citation" do
      update_citation_params = @citation.attributes
      update_citation_params[:site_title] = Faker::Book.title
      update_citation_params[:recipe_id] = @citation.recipe.id
      patch manage_legacy_recipe_citation_url(@citation.recipe.id, @citation), params: {citation: update_citation_params}
      assert_response :found
      assert_redirected_to manage_legacy_recipe_citation_url(@citation.recipe.id, @citation)
    end

    should"destroy citation" do
      delete manage_legacy_recipe_citation_url(@citation.recipe.id, @citation)
      assert_response :found
      assert_redirected_to manage_legacy_recipe_url(@citation.recipe.id)
    end
  end

  context 'cannot access unauthorized resources' do
    setup do
      @authorized_citation = FactoryBot.create(:citation)
      @authorized_user = @authorized_citation.recipe.user

      @unauthorized_citation = FactoryBot.create(:citation)
      @unauthorized_user = @unauthorized_citation.recipe.user

      sign_in @unauthorized_user
    end

    should"get show" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user citation recipes

      assert_raises ActionPolicy::Unauthorized do
        get manage_legacy_recipe_citation_url(@authorized_citation.recipe.id, @authorized_citation)
      end
    end

    should"get new" do
      # NOTE: Currently new is allowed by everyone, as it just gets the a page to make a new citation

      get new_manage_legacy_recipe_citation_url(@authorized_citation.recipe.id)
      assert_response :success
    end

    should"create citation" do
      # NOTE: Expected to fail, as user should not be able to add citation to recipe they do not own
      new_citation_params = {content_type: Citation::CONTENT_TYPES.to_a.sample, origin: Citation::ORIGINS.to_a.sample}
      assert_raises ActionPolicy::Unauthorized do
        post manage_legacy_recipe_citations_url(@authorized_citation.recipe.id), params: {citation: new_citation_params}
      end
    end

    should"get edit" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user citation recipes

      assert_raises ActionPolicy::Unauthorized do
        get edit_manage_legacy_recipe_citation_url(@authorized_citation.recipe.id, @authorized_citation)
      end
    end

    should"update citation" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed update @authorized_user_recipes

      assert_raises ActionPolicy::Unauthorized do
        update_citation_params = @authorized_citation.attributes
        update_citation_params[:site_title] = Faker::Book.title
        update_citation_params[:recipe_id] = @authorized_citation.recipe.id
        patch manage_legacy_recipe_citation_url(@authorized_citation.recipe.id, @authorized_citation), params: {citation: update_citation_params}
      end
    end

    should "destroy citation" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user recipes

      assert_raises ActionPolicy::Unauthorized do
        delete manage_legacy_recipe_citation_url(@authorized_citation.recipe.id, @authorized_citation)
      end
    end
  end
end
