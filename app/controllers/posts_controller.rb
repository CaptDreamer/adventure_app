class PostsController < ApplicationController
	before_action :signed_in_user

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
  			@feed_items = []
  			render 'new'
  		end
	end



  private

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
