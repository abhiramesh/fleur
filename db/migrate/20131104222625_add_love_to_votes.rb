class AddLoveToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :love, :boolean
  end
end
