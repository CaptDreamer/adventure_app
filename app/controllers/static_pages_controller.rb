class StaticPagesController < ApplicationController
  def home
  	@posts = Post.paginate(page: params[:page])
  end

  def games
  end

  def company
  end
end
