# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include UsersHelper

  protected

  #def configure_permitted_parameters
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
  #end

  def configure_permitted_parameters
    added_attrs = [:name, :user_name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
