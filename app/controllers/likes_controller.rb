class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @micropost = Micropost.find(params[:micropost_id])
    unless current_user.already_liked?(@micropost)
      current_user.like(@micropost)
      @micropost.create_notification_like!(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    else
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    if current_user.already_liked?(@micropost)
      current_user.unlike(@micropost)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    else
      redirect_to request.referrer || root_url
    end
  end

end
