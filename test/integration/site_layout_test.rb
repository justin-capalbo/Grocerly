require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @new_user = users(:newuser)
  end

  test "layout links" do
    # Go to home page before logging in 
    get root_path
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", new_user_registration_path, count: 2
    assert_select "a[href=?]", new_user_session_path 

    # After signing in we get a lot more links in our layout 
    sign_in @new_user
    get root_path
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", new_list_path, count: 2
    assert_select "a[href=?]", lists_path

    # Create a list  
    post lists_path, params: { list: { name: "Groceries" } }

    # There shouldn't be a second new list path but there should be some other new links
    # in addition to item links
    get root_path
    assert_select "a[href=?]", new_list_path, count: 1
      
  end
end
