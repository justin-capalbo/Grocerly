require 'test_helper'

class ListTest < ActiveSupport::TestCase
  def setup
    @user = users(:justin)
    @list = @user.lists.build(name: "Groceries")
  end

  test "should be valid" do
    assert @list.valid?
  end

  test "user id should be present" do
    @list.user_id = nil 
    assert_not @list.valid?
  end

  test "name should be present" do
    @list.name = "    "
    assert_not @list.valid?
  end

  test "name should be at most 25 characters" do
    @list.name = 'a' * 26
    assert_not @list.valid?
  end
  
  test "associated items should be destroyed" do
    @list.save
    3.times do
      @list.items.create!(name: Faker::Food.ingredient)
    end
    assert_difference 'Item.count', -3 do
      @list.destroy
    end
  end

end
