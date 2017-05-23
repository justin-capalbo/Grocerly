class AddIndexToItemsListIdCreatedAt < ActiveRecord::Migration[5.1]
  def change
    add_index :items, [:created_at, :id]
  end
end
