class ApplicationController < ActionController::Base


  def authorized_user?
    session[:authorized_user_id].present?
    # if session[:authorized_user_id]
    #   @authorized_user ||= User.find(session[:authorized_user_id])
    # else
    #   @authorized_user = nil
    # end
  end
  helper_method :authorized_user?

  def authorized_user_id
    session[:authorized_user_id] || 'na'
  end
  helper_method :authorized_user_id

  def current_user
    session[:authorized_user_id]
  end
  helper_method :current_user

end
