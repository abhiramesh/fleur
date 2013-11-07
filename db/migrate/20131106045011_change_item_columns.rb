class ChangeItemColumns < ActiveRecord::Migration
  def up
  	change_column :items, :name, :text
  	change_column :items, :image, :text
  	change_column :items, :desc, :text
  	change_column :items, :src_url, :text
  end

  def down
  end
end
