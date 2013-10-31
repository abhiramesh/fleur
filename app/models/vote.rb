class Vote < ActiveRecord::Base
   attr_accessible :like, :item_id, :user_id

   belongs_to :user
   belongs_to :item
end
