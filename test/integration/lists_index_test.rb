require 'test_helper'

class ListsIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = create(:user_with_no_items)
    @newuser = create(:user)
  end

  test "index as regular user" do
    sign_in @user 
    15.times do |n|
      @user.lists.create!(name: "#{n}")
    end
    get lists_path
    assert_select 'div.pagination'  
    @user.lists.paginate(page: 1) do |list|
      assert_match list.name, response.body
    end
  end

  test "user can only view their own lists" do
    # Generate a random list name for another user
    name = ('a'..'z').to_a.shuffle[0,8].join
    @newuser.lists.create!(name: name) 
    # I can see my own list but not the other user's.
    sign_in @user
    get lists_path
    assert_no_match name, response.body 
    assert_match @user.active_list.name, response.body
  end
  
end
