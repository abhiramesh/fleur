class Api::V1::UsersController < ApplicationController

	#before_filter :authenticate_user_from_token!
 	#before_filter :authenticate_user!

	def signup
		if params["email"]
			user = User.find_by_email(params["email"])
		elsif params["oauth_token"]
			graph = Koala::Facebook::API.new(params["oauth_token"])
			me = graph.get_object("me")
			user = User.find_by_email(me["email"])
		end
		if user
			render json: "An account with that email already exists! Please login."
		else
			if params["email"] && params["password"]
				new_user = User.create(email: params["email"], password: params["password"])
			elsif params["oauth_token"] && Time.parse(params["expires_at"])
				graph = Koala::Facebook::API.new(params["oauth_token"])
				me = graph.get_object("me")
				uid = me["id"]
				name = me["name"]
				email = me["email"]
				new_user = User.create(email: email, password: Devise.friendly_token)
				if new_user
					auth = Authorization.create(user_id: new_user.id, provider: "facebook", oauth_token: params["oauth_token"], oauth_expires_at: Time.parse(params["expires_at"]), uid: uid, name: name)
				end
			end
			if new_user.save
				sign_in new_user
				render json: {auth_token: new_user.authentication_token, email: new_user.email}
			else
				render :json => {:errors => new_user.errors.full_messages}
			end
		end
	end

	def login
		if params["email"]
			user = User.find_by_email(params["email"])
			if user && user.valid_password?(params["password"])
				user.ensure_authentication_token!
				sign_in user
				render json: {auth_token: user.authentication_token, email: user.email}
			else
				render json: "Invalid email or password"
			end
		elsif params["oauth_token"]
			graph = Koala::Facebook::API.new(params["oauth_token"])
			me = graph.get_object("me")
			user = User.find_by_email(me["email"])
			if user && Authorization.where(user_id: user.id)
				user.ensure_authentication_token!
				sign_in user
				render json: {auth_token: user.authentication_token, email: user.email}
			else
				render json: "Invalid email or password"
			end
		end
	end

end