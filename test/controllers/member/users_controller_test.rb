require "test_helper"

class Member::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get member_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get member_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get member_users_update_url
    assert_response :success
  end

  test "should get confirm" do
    get member_users_confirm_url
    assert_response :success
  end

  test "should get destroy" do
    get member_users_destroy_url
    assert_response :success
  end
end
