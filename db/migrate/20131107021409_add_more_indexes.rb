class AddMoreIndexes < ActiveRecord::Migration
  def up
  	add_index :actions, :user_id
  	add_index :votes, :user_id
  	add_index :votes, :item_id
  	add_index :authorizations, :user_id
  end

  def down
  end
end
