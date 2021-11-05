require "test_helper"

class Manage::Legacy::RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manage_legacy_recipes_index_url
    assert_response :success
  end

  test "should get show" do
    get manage_legacy_recipes_show_url
    assert_response :success
  end

  test "should get new" do
    get manage_legacy_recipes_new_url
    assert_response :success
  end

  test "should get create" do
    get manage_legacy_recipes_create_url
    assert_response :success
  end

  test "should get edit" do
    get manage_legacy_recipes_edit_url
    assert_response :success
  end

  test "should get update" do
    get manage_legacy_recipes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get manage_legacy_recipes_destroy_url
    assert_response :success
  end
end
