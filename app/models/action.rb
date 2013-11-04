class Action < ActiveRecord::Base
   attr_accessible :title, :points, :user_id
   belongs_to :user
end
