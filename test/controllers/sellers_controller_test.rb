require "test_helper"

class SellersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @seller = sellers(:one)
  end

  test "should get index" do
    get sellers_path
    assert_response :success
  end

  test "should get show" do
    get seller_path(@seller)
    assert_response :success
  end
end

