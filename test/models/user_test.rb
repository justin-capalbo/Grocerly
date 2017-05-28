require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")  
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "     " 
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     " 
    assert_not @user.valid?
  end

  test "username should be at most 50 characters" do
    @user.username = 'a' * 51
  end

end
