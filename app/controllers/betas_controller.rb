class BetasController < ApplicationController

	def create
		count = Beta.all.count.to_i
		position = count + 1
		if request.referrer.to_s.include? "refid="
			referrer = request.referrer.to_s.split('?refid=').last
		end
		viral = loop do
			viral = SecureRandom.urlsafe_base64(10)
			break viral unless Beta.where(viral: viral).first
		end
		@beta = Beta.create!(:email => params["beta"]["email"], :position => position, :referrer => referrer, :viral => viral)
		respond_to do |format|
			format.js
		end
	end

end
