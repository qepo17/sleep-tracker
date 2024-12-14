require "test_helper"

class SleepRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sleep_records_index_url
    assert_response :success
  end
end
