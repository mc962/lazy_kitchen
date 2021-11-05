require "test_helper"

class Manage::Legacy::StepIngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manage_legacy_step_ingredients_index_url
    assert_response :success
  end

  test "should get show" do
    get manage_legacy_step_ingredients_show_url
    assert_response :success
  end

  test "should get new" do
    get manage_legacy_step_ingredients_new_url
    assert_response :success
  end

  test "should get create" do
    get manage_legacy_step_ingredients_create_url
    assert_response :success
  end

  test "should get edit" do
    get manage_legacy_step_ingredients_edit_url
    assert_response :success
  end

  test "should get update" do
    get manage_legacy_step_ingredients_update_url
    assert_response :success
  end

  test "should get destroy" do
    get manage_legacy_step_ingredients_destroy_url
    assert_response :success
  end
end
