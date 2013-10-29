class Authorization < ActiveRecord::Base
   attr_accessible :user_id, :provider, :oauth_token, :oauth_expires_at, :uid, :name

   belongs_to :user
   
end