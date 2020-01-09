class MicropostsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :destroy]

  def new
    @micropost = current_user.microposts.build if user_signed_in?
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿成功！"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private
  #protectedとどう使い分けたら良い？

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end





end
