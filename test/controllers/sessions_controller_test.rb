require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Grocerist"
  end

  test "should get new" do
    get new_user_session_url
    assert_response :success  
    assert_select "title", "Log in | #{@base_title}"
  end

end
