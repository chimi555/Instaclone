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
    added_attrs = [:name, :user_name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
