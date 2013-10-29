class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
    	t.integer :user_id
    	t.string :provider
    	t.string :oauth_token
    	t.string :oauth_expires_at
    	t.string :uid
    	t.string :name
      t.timestamps
    end
  end
end
