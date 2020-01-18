# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  include UsersHelper

  def set_search
    @search = Micropost.ransack(params[:q])
    @search_microposts = @search.result.paginate(page: params[:page])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name user_name email remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name user_name email image image_cache remove_image url profile phone gender password])
  end
end
