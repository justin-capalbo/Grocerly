require 'test_helper'

class HomepageListFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:justin)
    @barb = users(:barb)
  end
  
  test "item creation" do
    sign_in @barb
    get root_path

    # I can add an item to my own list
    @list = lists(:groceries_barb)
    assert_difference 'Item.count', 1 do
      post items_path, params: { list_id: @list.id,
                                 item: { name: "New Item",
                                         notes: "Notes" } }
    end
    assert_not flash.empty?

    # I can't add an item to someone elses list
    other_list = @user.lists.first
    assert_no_difference 'Item.count' do
      post items_path, params: { list_id: other_list.id,
                                 item: { name: "New Item",
                                         notes: "Notes" } }
    end
    assert_redirected_to root_url
  end

  test "item deletion" do
    sign_in @user
    get root_path
    @list = assigns(:list)
    items = @list.items.paginate(page: 1)

    # The homepage should paginate active list items
    assert_select 'div.pagination'
    items.each do |item|
      assert_match item.name, response.body
    end

    # There should be a delete link for items, and
    # I can delete an item as the logged in user
    @first_item = items(:grocery_1)
    @second_item = items(:grocery_2)
    assert_select "a[href=?]", item_path(@first_item)
    assert_difference 'Item.count', -1 do
      delete item_path(@first_item)
    end
    assert_not flash.empty?

    # Can't delete another user's item
    sign_in @barb 
    get root_path
    assert_select "a[href=?]", item_path(@second_item), count: 0
    assert_no_difference 'Item.count' do
      delete item_path(@second_item)
    end
    assert_redirected_to root_url
  end
end


