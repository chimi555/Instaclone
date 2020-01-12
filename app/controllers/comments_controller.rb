class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to micropost_path(@micropost)
    else
      redirect_to micropost_path(@micropost)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referrer || micropost_path(@micropost)
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :micropost_id, :user_id)
    end

end
