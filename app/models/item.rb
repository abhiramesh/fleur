class Item < ActiveRecord::Base
   attr_accessible :name, :image, :desc, :src_url

   has_many :votes
   has_many :users, through: :votes
   
end
