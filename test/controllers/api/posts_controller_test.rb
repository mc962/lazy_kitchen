require "test_helper"

class API::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get api_posts_show_url
    assert_response :success
  end
end
