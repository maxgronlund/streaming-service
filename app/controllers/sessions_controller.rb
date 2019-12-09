class SessionsController < ApplicationController
  require 'rbnacl'
  require 'uri'

  # def create
  #   params.permit!

  #   payload = {
  #       action: "CREATE_SESSION",
  #       email: params[:email],
  #       password: params[:password]
  #     }.to_json

  #   response =
  #     Excon.post(
  #       ENV["BACKEND_API_URL"],
  #       :headers => {
  #         "Content-Type" => "application/json",
  #         "Api-Version" => "1.0",
  #         "Client-ID" => URI::encode(ENV['STREAMING_CLIENT_ID'])
  #       },
  #       body: {payload: SecretBox.encrypt(payload)}.to_json
  #     )

  #   case response.status
  #   when 200
  #     login(response) ? redirect_to(root_path) : redirect_to(new_session_path)
  #   when 401
  #     redirect_to(new_session_path, notice: '401 Unknown account.')
  #   when 404
  #     redirect_to(new_session_path, notice: ' 404 Unknown account.')
  #   when 422
  #     redirect_to(new_session_path, notice: ' 422 Unknown account.')
  #   else
  #     redirect_to(new_session_path)
  #   end

  # end

  # def login(response)
  #   response_body = JSON.parse(response.body)
  #   ap response_body

  #   case response_body["status"]
  #   when "ok"
  #     session[:authorized_user_id] = response_body["user_id"]
  #     true
  #   else
  #     false
  #   end
  # end


  def destroy
    session[:authorized_user_id] = nil
    redirect_to root_path
  end
end
