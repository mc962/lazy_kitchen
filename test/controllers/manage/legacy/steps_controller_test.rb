require "test_helper"

class Manage::Legacy::StepsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manage_legacy_steps_index_url
    assert_response :success
  end

  test "should get show" do
    get manage_legacy_steps_show_url
    assert_response :success
  end

  test "should get new" do
    get manage_legacy_steps_new_url
    assert_response :success
  end

  test "should get create" do
    get manage_legacy_steps_create_url
    assert_response :success
  end

  test "should get edit" do
    get manage_legacy_steps_edit_url
    assert_response :success
  end

  test "should get update" do
    get manage_legacy_steps_update_url
    assert_response :success
  end

  test "should get destroy" do
    get manage_legacy_steps_destroy_url
    assert_response :success
  end
end
