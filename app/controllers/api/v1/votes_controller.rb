class Api::V1::VotesController < ApplicationController

	before_filter :authenticate_user_from_token!
 	before_filter :authenticate_user!

	def like_item
		item = Item.where(id: params["item_id"].to_i).first
		if item && current_user
			vote = Vote.where(item_id: item.id, user_id: current_user.id).first
			vote.like = true
			vote.save!
			action = Action.create(:title => "swipe", :points => 1, :user_id => current_user.id)
			current_user.points = current_user.points.to_i + action.points
			current_user.save
			if vote.save && action.save && current_user.save
				vote.delay.send_like_to_predict
				render json: { status: "Item Liked!" }
			else
				render json: { status: "Something went wrong!" }
			end
		else
			render json: { status: "Something went wrong!" }
		end
	end

	def dislike_item
		item = Item.where(id: params["item_id"].to_i).first
		if item && current_user
			vote = Vote.where(item_id: item.id, user_id: current_user.id).first
			vote.like = false
			vote.save!
			action = Action.create(:title => "swipe", :points => 1, :user_id => current_user.id)
			current_user.points = current_user.points.to_i + action.points
			current_user.save
			if vote.save && action.save && current_user.save
				vote.delay.send_dislike_to_predict
				render json: { status: "Item Disliked!" }
			else
				render json: { status: "Something went wrong!" }
			end
		else
			render json: { status: "Something went wrong!" }
		end
	end

	def love_item
		item = Item.where(id: params["item_id"].to_i).first
		if item && current_user
			vote = Vote.where(item_id: item.id, user_id: current_user.id).first
			vote.like = true
			vote.love = true
			vote.save!
			action = Action.create(:title => "love", :points => 1, :user_id => current_user.id)
			current_user.points = current_user.points.to_i + action.points
			current_user.save
			if vote.save && action.save && current_user.save
				vote.delay.send_love_to_predict
				render json: { status: "Item Loved!" }
			else
				render json: { status: "Something went wrong!" }
			end
		else
			render json: { status: "Something went wrong!" }
		end
	end

end
