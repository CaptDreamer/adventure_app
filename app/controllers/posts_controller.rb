class PostsController < ApplicationController
	before_action :signed_in_user, except: [:show]

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created!"
			redirect_to root_url
		else
  			render 'new'
  		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash[:success] = "Post updated!"
			redirect_to root_url
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id]).destroy
    	flash[:success] = "Post deleted."
    	redirect_to root_url
    end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
