require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "ExampleUser", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")  
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "     " 
    assert_not @user.valid?
  end

  test "username should not contain whitespace" do
    @user.username = "Invalid User" 
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     " 
    assert_not @user.valid?
  end

  test "username should be at most 50 characters" do
    @user.username = 'a' * 51
  end

  test "associated lists should be destroyed" do
    @user.save
    @user.lists.create!(name: "Groceries")
    assert_difference 'List.count', -1 do
      @user.destroy
    end
  end

  test "active list should be newest list chronologically" do
    justin = users(:justin) 
    assert_equal justin.active_list, justin.lists.order(created_at: :desc).first
  end
end
