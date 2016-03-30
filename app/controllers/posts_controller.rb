class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post, :only => [:show, :edit, :update, :destroy]
  before_action :check_user, :only => [:edit, :update, :destroy]
  def index
    @posts = Post.page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = '成功張貼訊息'
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)

      flash[:notice] = '成功更新訊息'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    flash[:notice] = '成功刪除訊息'

    redirect_to posts_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def check_user
    if @post.user != current_user
      flash[:alert] = '抱歉你不是作者沒有此權限'
      redirect_to posts_path
      return
    end
  end

  def post_params
    params.require(:post).permit(:topic, :content, :category_id)
  end

end
