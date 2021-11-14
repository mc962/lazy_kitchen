require "test_helper"

class LandingsControllerTest < ApplicationControllerTestCase
  test "should get home" do
    get root_path
    assert_response :success
  end
end
