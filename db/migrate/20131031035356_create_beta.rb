class CreateBeta < ActiveRecord::Migration
  def change
    create_table :beta do |t|
    	t.string :email
    	t.integer :position
      t.timestamps
    end
  end
end
