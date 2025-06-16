require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get download" do
    get pages_download_url
    assert_response :success
  end

  test "should get quick_run" do
    get pages_quick_run_url
    assert_response :success
  end

  test "should get infra_action" do
    get pages_infra_action_url
    assert_response :success
  end
end
