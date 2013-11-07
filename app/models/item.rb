class Item < ActiveRecord::Base
   attr_accessible :name, :image, :desc, :src_url

   has_many :votes
   has_many :users, through: :votes
   

   def item_seen?(user)
   	Vote.where(item_id: self.id, user_id: user.id).exists?
   end

end
