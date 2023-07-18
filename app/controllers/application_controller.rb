class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  def welcome
    @users = user_signed_in? ? User.all : []
  end

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end
  
end
