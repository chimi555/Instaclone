class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.like(micropost)
    redirect_to root_url
  end

  def destroy
    micropost = Like.find(params[:id]).micropost
    current_user.unlike(micropost)
    redirect_to root_url
  end

end
