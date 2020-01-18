# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @micropost = Micropost.find(params[:micropost_id])
    if current_user.already_liked?(@micropost)
      redirect_to request.referrer || root_url
    else
      current_user.like(@micropost)
      @micropost.create_notification_like!(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        # format.js 呼び出されない なんで？
      end
    end
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    if current_user.already_liked?(@micropost)
      current_user.unlike(@micropost)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        # format.js  呼び出されない なんで？
      end
    else
      redirect_to request.referrer || root_url
    end
  end
end
