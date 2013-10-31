class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.string :name
    	t.string :image
    	t.string :desc
    	t.string :src_url
      t.timestamps
    end
  end
end
