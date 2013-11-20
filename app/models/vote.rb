class Vote < ActiveRecord::Base
   attr_accessible :like, :love, :item_id, :user_id

   belongs_to :user
   belongs_to :item

   

   def send_like_to_predict
   	
   end

   def send_dislike_to_predict
   
   end

    def send_love_to_predict
   	
   end

end
