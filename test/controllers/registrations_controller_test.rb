require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = create(:user) 
    @base_title = "Grocerist"
  end

  test "should get new" do
    get new_user_registration_url
    assert_response :success  
    assert_select "title", "Sign up | #{@base_title}"
  end

  test "should redirect edit when not logged in" do
    get edit_user_registration_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_path 
  end

  test "should get edit when logged in" do
    sign_in @user    
    get edit_user_registration_path
    assert flash.empty?
    assert_template 'devise/registrations/edit' 
    assert_select "title", "My account | #{@base_title}"
  end

  test "cancel registration should redirect to signup page if not logged in" do
    assert_no_difference 'User.count' do
      get cancel_user_registration_path(@user)
    end
    assert_redirected_to new_user_registration_path
  end

  test "successful update" do
    sign_in @user
    get edit_user_registration_path
    assert_template 'devise/registrations/edit'
    new_username = "newname"
    new_email = "new@email.com"
    params = { user:  { username: new_username,
                        email: new_email,
                        current_password: 'password' } }

    patch user_registration_path, params:  params
    assert_equal new_username, @user.reload.username 
    assert_equal new_email, @user.reload.email 
    assert_redirected_to root_url
  end
end

