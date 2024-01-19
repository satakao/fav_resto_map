require 'test_helper'

class Member::PostCommentsControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get member_post_comments_create_url
    assert_response :success
  end

  test 'should get destroy' do
    get member_post_comments_destroy_url
    assert_response :success
  end
end
