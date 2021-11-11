require "test_helper"

class Manage::Legacy::AuthorsControllerTest < ApplicationControllerTestCase
  context 'unauthenticated user' do
    setup do
      @author = FactoryBot.create(:author)
    end

    should"show author" do
      get manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id, @author)
      assert_response :found
    end

    should"new author" do
      get new_manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id)
      assert_response :found
    end

    should"create author" do
      post manage_legacy_recipe_citation_authors_url(@author.citation.recipe.id, @author.citation.id), params: {}
      assert_response :found
    end

    should"edit author" do
      get edit_manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id, @author)
      assert_response :found
    end

    should"update author" do
      patch manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id, @author)
      assert_response :found
    end

    should"destroy author" do
      delete manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id, @author)
      assert_response :found
    end
  end

  context 'authenticated user' do
    setup do
      @author = FactoryBot.create(:author)
      @user = @author.citation.recipe.user
      sign_in @user
    end

    should"show author" do
      get manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id, @author)
      assert_response :success
    end

    should"new author" do
      get new_manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id)
      assert_response :success
    end

    should"create author" do
      new_author_params = {first_name: Faker::Name.first_name}
      post manage_legacy_recipe_citation_authors_url(@author.citation.recipe.id, @author.citation.id), params: {
        author: new_author_params
      }
      assert_response :found

      author = Author.where(first_name: new_author_params[:first_name]).last
      assert_redirected_to manage_legacy_recipe_citation_author_url(author.citation.recipe.id, author.citation.id, author)
    end

    should"edit author" do
      get edit_manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id, @author)
      assert_response :success
    end

    should"update author" do
      update_author_params = @author.attributes
      update_author_params[:first_name] = Faker::Name.first_name
      update_author_params[:citation_id] = @author.citation.id

      patch manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id, @author),
            params: {author: update_author_params}
      assert_response :found

      author = Author.managed.where(first_name: update_author_params[:first_name]).last
      assert_redirected_to manage_legacy_recipe_citation_author_url(author.citation.recipe.id, author.citation.id, author)
    end

    should"destroy author" do
      delete manage_legacy_recipe_citation_author_url(@author.citation.recipe.id, @author.citation.id, @author)
      assert_response :found
    end
  end

  context 'cannot access unauthorized resources' do
    setup do
      @authorized_author = FactoryBot.create(:author)
      @authorized_user = @authorized_author.citation.recipe.user

      @unauthorized_author = FactoryBot.create(:author)
      @unauthorized_user = @unauthorized_author.citation.recipe.user

      sign_in @unauthorized_user
    end

    should"get show" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user author recipes

      assert_raises ActionPolicy::Unauthorized do
        get manage_legacy_recipe_citation_author_url(@authorized_author.citation.recipe.id, @authorized_author.citation.id, @authorized_author)
      end
    end

    should"get new" do
      # NOTE: Currently new is allowed by everyone, as it just gets the a page to make a new author

      get new_manage_legacy_recipe_citation_author_url(@authorized_author.citation.recipe.id, @authorized_author.citation.id)
      assert_response :success
    end

    should"create author" do
      # NOTE: Expected to fail, as user should not be able to add author to recipe they do not own
      new_author_params = {first_name: Faker::Name.first_name}
      assert_raises ActionPolicy::Unauthorized do
        post manage_legacy_recipe_citation_authors_url(@authorized_author.citation.recipe.id, @authorized_author.citation.id), params: {author: new_author_params}
      end
    end

    should"get edit" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user author recipes

      assert_raises ActionPolicy::Unauthorized do
        get edit_manage_legacy_recipe_citation_author_url(@authorized_author.citation.recipe.id, @authorized_author.citation.id, @authorized_author)
      end
    end

    should"update author" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed update @authorized_user_recipes

      assert_raises ActionPolicy::Unauthorized do
        update_author_params = @authorized_author.attributes
        update_author_params[:first_name] = Faker::Name.first_name
        update_author_params[:citation_id] = @authorized_author.citation.id
        patch manage_legacy_recipe_citation_author_url(@authorized_author.citation.recipe.id, @authorized_author.citation.id, @authorized_author), params: {author: update_author_params}
      end
    end

    should "destroy author" do
      # NOTE: Expected to fail, as the signed in @unauthorized_user is not allowed access to @authorized_user recipes

      assert_raises ActionPolicy::Unauthorized do
        delete manage_legacy_recipe_citation_author_url(@authorized_author.citation.recipe.id, @authorized_author.citation.id, @authorized_author)
      end
    end
  end

end
