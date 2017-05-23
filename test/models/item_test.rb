require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @list = lists(:groceries)
    @item = @list.items.build(name: Faker::Food.ingredient, notes: "notes")
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "list id should be present" do
    @item.list_id = nil 
    assert_not @item.valid?
  end

  test "name should be present" do
    @item.name = "    "
    assert_not @item.valid?
  end

  test "name should be at most 30 characters" do
    @item.name = 'a' * 31 
    assert_not @item.valid?
  end
  
  test "notes should be at most 255 characters" do
    @item.notes = 'a' * 256 
    assert_not @item.valid?
  end
end
