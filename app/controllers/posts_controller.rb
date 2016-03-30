class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post, :only => [:show, :destroy]

  def index
    @posts = Post.page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save

    flash[:notice] = '成功張貼訊息'
    redirect_to posts_path
  end

  def show
    @comment = Comment.new
  end

  def destroy
    if @post.user == current_user
      @post.destroy

      flash[:notice] = '成功刪除訊息'
    else
      flash[:alert] = '抱歉你不是作者不能刪除'
    end

    redirect_to posts_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:topic, :content, :category_id)
  end

end
