class AddIndexToListsUserIdCreatedAt < ActiveRecord::Migration[5.1]
  def change
    add_index :lists, [:created_at, :list_id]
  end
end
