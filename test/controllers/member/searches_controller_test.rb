require 'test_helper'

class Member::SearchesControllerTest < ActionDispatch::IntegrationTest
  test 'should get search' do
    get member_searches_search_url
    assert_response :success
  end
end
