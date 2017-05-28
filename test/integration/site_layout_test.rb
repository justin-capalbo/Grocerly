require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:justin)
  end
  
  test "layout links" do
    # Go to home page before logging in 
    get root_url
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", new_user_registration_path, count: 2
    assert_select "a[href=?]", new_user_session_path 
    sign_in @user
    get root_url
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
   end
end
