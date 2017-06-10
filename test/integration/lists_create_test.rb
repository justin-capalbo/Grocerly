require 'test_helper'

class ListsCreateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = create(:user)
  end

  test "Invalid list information" do
    sign_in @user
    get new_list_path
    assert_no_difference 'List.count' do
      post lists_path, params: { list: { name: "" } }
    end
    assert_template 'lists/new'
    assert_select 'div#error_explanation'
  end

  test "Valid list information" do
    sign_in @user
    get new_list_path
    
    # I can create a list 
    test_name = "A cool name" 
    second_name = "Not as cool" 
    assert_difference 'List.count', 1 do
      post lists_path, params: { list: { name: test_name } } 
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'div.alert-success' 
    assert_select 'h3.list-name', text: test_name
    
    # The active list is the newest list chronologically 
    get new_list_path
    post lists_path, params: { list: { name: second_name } }
    follow_redirect!
    assert_select 'h3.list-name', text: second_name
  end
end
