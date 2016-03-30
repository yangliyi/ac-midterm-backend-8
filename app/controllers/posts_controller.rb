class PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)

    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  private

  def post_params
    params.require(:post).permit(:topic, :content, :category_id)
  end

end
