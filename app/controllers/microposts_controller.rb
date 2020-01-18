# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy show]
  before_action :correct_user, only: :destroy

  def index
    if user_signed_in?
      render 'index'
    else
      render '/users/sign_in'
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = '投稿成功！'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def new
    @micropost = current_user.microposts.build if user_signed_in?
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comment = Comment.new
    @comments = @micropost.comments
  end

  def destroy
    if current_user
      @micropost.destroy
      flash[:success] = 'Micropost deleted'
      redirect_to request.referrer || root_url
    else
      redirect_to request.referrer || root_url
    end
  end

  private

  # protectedとどう使い分けたら良い？

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
