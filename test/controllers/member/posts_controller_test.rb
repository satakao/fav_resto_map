require "test_helper"

class Member::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get member_posts_show_url
    assert_response :success
  end

  test "should get destroy" do
    get member_posts_destroy_url
    assert_response :success
  end

  test "should get update" do
    get member_posts_update_url
    assert_response :success
  end

  test "should get edit" do
    get member_posts_edit_url
    assert_response :success
  end

  test "should get create" do
    get member_posts_create_url
    assert_response :success
  end
end
