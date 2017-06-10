require 'test_helper'

class ListTest < ActiveSupport::TestCase
  def setup
    @list = build(:list_with_items)
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
    assert_difference 'Item.count', -1 * @list.items.count do
      @list.destroy
    end
  end

end
