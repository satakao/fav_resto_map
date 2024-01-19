require 'test_helper'

class Member::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get member_relationships_create_url
    assert_response :success
  end

  test 'should get destroy' do
    get member_relationships_destroy_url
    assert_response :success
  end
end
