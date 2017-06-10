require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user, username: "ValidUser")
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
    user = create(:user_with_no_items)
    assert_difference 'List.count', -1 * user.lists.count do
      user.destroy
    end
  end

  test "active list should be newest list chronologically" do
    @user.save
    create(:list, user: @user, created_at: 5.days.ago)
    create(:list, user: @user, created_at: 5.hours.ago)
    assert_equal @user.active_list, @user.lists.order(created_at: :desc).first
  end
end
