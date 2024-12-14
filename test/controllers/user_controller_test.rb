require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get follow" do
    get user_follow_url
    assert_response :success
  end
end
