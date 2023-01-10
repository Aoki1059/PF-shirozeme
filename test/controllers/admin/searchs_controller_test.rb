require "test_helper"

class Admin::SearchsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get admin_searchs_search_url
    assert_response :success
  end
end
