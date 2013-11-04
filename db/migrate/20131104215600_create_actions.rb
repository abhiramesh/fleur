class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
    	t.string :title
    	t.integer :points
    	t.integer :user_id
      t.timestamps
    end
  end
end
