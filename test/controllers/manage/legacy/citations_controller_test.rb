require "test_helper"

class Manage::Legacy::CitationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get manage_legacy_citations_show_url
    assert_response :success
  end

  test "should get new" do
    get manage_legacy_citations_new_url
    assert_response :success
  end

  test "should get create" do
    get manage_legacy_citations_create_url
    assert_response :success
  end

  test "should get edit" do
    get manage_legacy_citations_edit_url
    assert_response :success
  end

  test "should get update" do
    get manage_legacy_citations_update_url
    assert_response :success
  end

  test "should get destroy" do
    get manage_legacy_citations_destroy_url
    assert_response :success
  end
end
