# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      # @comment.micropost.create_notification_comment(current_user, @comment.id) ここを足したことによりAjax反応しなくなる、なんで？
      render :comment_index
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    render :comment_index if @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :micropost_id, :user_id)
  end
end
