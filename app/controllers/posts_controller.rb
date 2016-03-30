class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:topic, :content, :category_id)
  end

end