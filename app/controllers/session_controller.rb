class SessionController < ApplicationController

  # def user
  #   params.permit!
  #   ap params

  # end

  def new

  end

  def create

  end

  def delete
    ap "===================="
    ap params["request_url"]
    session[:authorized_user_id] = nil
    redirect_to params["request_url"]
  end
end