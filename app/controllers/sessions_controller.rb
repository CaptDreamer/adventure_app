class SessionsController < ApplicationController
	def new
	end

	def destroy
	end

	def create
		user = User.find_by(username: params[:session][:username].downcase)
    	if user && user.authenticate(params[:session][:password])
      		sign_in user
      		redirect_to root_path
    	else
      		flash.now[:danger] = 'Invalid email/password combination'
      		render 'new'
    	end
  	end
end
