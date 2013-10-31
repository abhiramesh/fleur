class BetasController < ApplicationController

	def create
		count = Beta.all.count.to_i
		position = count + 1
		@beta = Beta.create(:email => params["beta"]["email"], :position => position)
		respond_to do |format|
			format.js
		end
	end

end
