class Api::V1::ItemsController < ApplicationController

	before_filter :authenticate_user_from_token!
 	before_filter :authenticate_user!

 	require 'will_paginate/array'

	def get_feed_items 
		@items = []
		Item.find_each do |item|
			if !item.item_seen?(current_user)
			@items << item				
			end
		break if @items.length == 12
		end
		Item.delay.create_vote(@items, current_user)

		render json: @items, :only => [:id, :image, :name, :src_url]
	end


	def get_loved_items
		@items = []
		@votes = current_user.votes.where(:love => true).paginate(:page => params[:page], :per_page => 15)
		@votes.each do |v|
			@items << v.item
		end
		render json: @items, :only => [:id, :image, :name, :src_url]
	end

end
