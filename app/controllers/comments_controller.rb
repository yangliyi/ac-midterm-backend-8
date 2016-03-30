class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @comment.save

    redirect_to post_path(@post)
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy

      flash[:notice] = '成功刪除留言'
    else
      flash[:alert] = '抱歉你不是作者不能刪除'
    end

    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
