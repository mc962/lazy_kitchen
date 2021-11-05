require "test_helper"

class Manage::Legacy::AuthorsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get manage_legacy_authors_show_url
    assert_response :success
  end

  test "should get new" do
    get manage_legacy_authors_new_url
    assert_response :success
  end

  test "should get create" do
    get manage_legacy_authors_create_url
    assert_response :success
  end

  test "should get edit" do
    get manage_legacy_authors_edit_url
    assert_response :success
  end

  test "should get update" do
    get manage_legacy_authors_update_url
    assert_response :success
  end

  test "should get destroy" do
    get manage_legacy_authors_destroy_url
    assert_response :success
  end
end
