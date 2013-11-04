class Api::V1::UsersController < ApplicationController

	def signup
		if params["email"] && params["password"]
			user = User.find_by_email(params["email"])
			if user
				render json: {status: ["An account with that email already exists! Please login."]}
			else
				new_user = User.create(email: params["email"], password: params["password"])
				if new_user.save
					render json: {auth_token: new_user.authentication_token, email: new_user.email, sign_in_count: new_user.sign_in_count.to_s}
				else
					render :json => {:status => new_user.errors.full_messages}
				end
			end
		elsif params["oauth_token"] && params["expires_at"]
			graph = Koala::Facebook::API.new(params["oauth_token"])
			me = graph.get_object("me")
			user = User.find_by_email(me["email"])
			if user
				auth = user.authorizations.find_by_provider("facebook")
			end
			if user && auth
				sign_in user
				auth.oauth_token = params["oauth_token"]
				user.save
				auth.save
				render json: {auth_token: user.authentication_token, email: user.email, sign_in_count: user.sign_in_count.to_s}
			elsif !user && !auth
				graph = Koala::Facebook::API.new(params["oauth_token"])
				me = graph.get_object("me")
				uid = me["id"]
				name = me["name"]
				email = me["email"]
				new_user = User.create(email: email, password: Devise.friendly_token)
				if new_user.save
					auth = Authorization.create(user_id: new_user.id, provider: "facebook", oauth_token: params["oauth_token"], oauth_expires_at: Time.parse(params["expires_at"]), uid: uid, name: name)
					sign_in new_user
					render json: {auth_token: new_user.authentication_token, email: new_user.email, sign_in_count: new_user.sign_in_count.to_s}
				else
					render :json => {:status => new_user.errors.full_messages}
				end
			end
		end
	end


	def login
		if params["email"] && params["password"]
			user = User.find_by_email(params["email"])
			if user && user.valid_password?(params["password"])
				user.save
				sign_in user
				render json: {auth_token: user.authentication_token, email: user.email, sign_in_count: user.sign_in_count.to_s}
			else
				render json: {status: ["Invalid email or password"]}
			end
		else
			render json: {status: ["Invalid email or password"]}
		end
	end

end