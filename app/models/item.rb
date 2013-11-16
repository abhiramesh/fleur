class Item < ActiveRecord::Base
   attr_accessible :name, :image, :desc, :src_url, :brand

   has_many :votes
   has_many :users, through: :votes
   

   def item_seen?(user)
   	Vote.where(item_id: self.id, user_id: user.id).exists?
   end

   def self.create_vote(items, user)
   	items.each do |item|
   		Vote.create(item_id: item.id, user_id: user.id)
   	end
   end

end
