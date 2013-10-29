class Api::V1::UsersController < ApplicationController

	#before_filter :authenticate_user_from_token!
 	#before_filter :authenticate_user!

	def signup
		user = User.find_by_email(params["email"])
		if user
			render json: "An account with that email already exists! Please login."
		else
			new_user = User.create(email: params["email"], password: params["password"])
			if new_user.save
				user.ensure_authentication_token!
				sign_in new_user
				render json: {auth_token: new_user.authentication_token, email: new_user.email}
			else
				render :json => {:errors => new_user.errors.full_messages}
			end
		end
	end

	def login
		user = User.find_by_email(params["email"])
		if user && user.valid_password?(params["password"])
			user.ensure_authentication_token!
			sign_in user
			render json: {auth_token: user.authentication_token, email: user.email}
		else
			render json: "Invalid email or password"
		end
	end

end
