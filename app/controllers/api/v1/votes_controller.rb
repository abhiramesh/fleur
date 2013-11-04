class Api::V1::VotesController < ApplicationController

	before_filter :authenticate_user_from_token!
 	before_filter :authenticate_user!

	def like_item
		#item = Item.find(params["item_id"])
		vote = Vote.create(:like => true, :item_id => 1, :user_id => current_user.id)
		action = Action.create(:title => "swipe", :points => 1, :user_id => current_user.id)
		current_user.points = current_user.points.to_i + action.points
		current_user.save
		if vote.save && action.save && current_user.save
			render json: { status: "Item Liked!" }
		else
			render json: { status: "Something went wrong!" }
		end
	end

	def dislike_item
		#item = Item.find(params["item_id"])
		vote = Vote.create(:like => false, :item_id => 1, :user_id => current_user.id)
		action = Action.create(:title => "swipe", :points => 1, :user_id => current_user.id)
		current_user.points = current_user.points.to_i + action.points
		current_user.save
		if vote.save && action.save && current_user.save
			render json: { status: "Item Disliked!" }
		else
			render json: { status: "Something went wrong!" }
		end
	end

	def love_item
		#item = Item.find(params["item_id"])
		vote = Vote.create(:like => true, :love => true, :item_id => 1, :user_id => current_user.id)
		action = Action.create(:title => "love", :points => 1, :user_id => current_user.id)
		current_user.points = current_user.points.to_i + action.points
		current_user.save
		if vote.save && action.save && current_user.save
			render json: { status: "Item Loved!" }
		else
			render json: { status: "Something went wrong!" }
		end
	end

end
