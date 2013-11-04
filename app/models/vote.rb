class Vote < ActiveRecord::Base
   attr_accessible :like, :love, :item_id, :user_id

   belongs_to :user
   belongs_to :item
end
