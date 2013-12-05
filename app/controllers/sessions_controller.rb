class SessionsController < ApplicationController
	def new
	end

	def destroy
    sign_out
    flash[:success] = "Successfully logged out!"
    redirect_to root_url
	end

	def create
		user = User.find_by(username: params[:session][:username].downcase)
    	if user && user.authenticate(params[:session][:password])
      		sign_in user
          flash[:success] = "Logged in as " + user.first_name 
      		redirect_to root_path
    	else
      		flash.now[:danger] = 'Invalid username/password combination'
      		render 'new'
    	end
  	end
end
