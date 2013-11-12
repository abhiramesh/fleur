class Api::V1::ItemsController < ApplicationController

	before_filter :authenticate_user_from_token!
 	before_filter :authenticate_user!

	def get_feed_items 
		@items = []
		Item.all.each do |item|
			if !item.item_seen?(current_user)
			@items << item				
			end
		break if @items.length == 15
		end
		render json: @items, :only => [:id, :image, :name, :src_url]
	end

	def get_liked_items
		@items = []
		@votes = current_user.votes.where(:like => true)
		@votes.each do |v|
			@items << v.item
		end
	end

	def get_loved_items
		@items = []
		@votes = current_user.votes.where(:love => true)
		@votes.each do |v|
			@items << v.item
		end
	end


end
