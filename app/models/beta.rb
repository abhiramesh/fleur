class Beta < ActiveRecord::Base
   attr_accessible :email, :position, :referrer, :viral

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

   acts_as_list

   def reward_beta_for_referral
   	if self.referrer != nil && referrer_first = Beta.where(:viral => self.referrer).first
   		2.times do
   			referrer_first.move_higher
   		end
   		if referrer_first.referrer != nil && referrer_minus_one = Beta.where(:viral => referrer_first.referrer).first
   			referrer_minus_one.move_higher
   		end
   	end
   end

   after_create :reward_beta_for_referral

end
