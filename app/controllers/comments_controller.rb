class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      @micropost.create_notification_comment!(current_user, @comment.id)
      render :comment_index
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :comment_index
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :micropost_id, :user_id)
    end

end
