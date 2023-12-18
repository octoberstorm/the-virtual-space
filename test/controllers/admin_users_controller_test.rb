require "test_helper"

class AdminUsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = admins(:one)
    @admin_user = users(:admin)
    @user = users(:one)

    sign_in @admin_user
  end

  test "should get index" do
    get admin_users_url
    assert_response :success
  end

  test "should get show" do
    get admin_user_url(@user)
    assert_response :success
  end

  test "should get new" do
    get new_admin_user_url
    assert_response :success
  end

  test "should get destroy" do
    delete admin_user_url(@user)
    assert_redirected_to admin_users_url
  end
end
