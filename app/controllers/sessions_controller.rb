class SessionsController < ApplicationController
  require 'rbnacl'
  require 'uri'

  def new
  end

  def create
    params.permit!

    payload = {
        email: params[:email],
        password: params[:password],
        signature: ENV['STREAMING_CLIENT_SECRET']
      }.to_json

    Rails.logger.debug payload

    secret_payload = SecretBox.encrypt(payload)

    # conn = Faraday.new(
      # url: 'http://localhost:4000/api/v1/',
#
      # params: {
        # email: params["email"],
        # pass: params["password"],
        # copper_dove_id: Rails.configuration.copper_dove_id
      # },
      # headers: {'Content-Type' => 'application/json'
      # }
    # )
#
    # resp = conn.get('users') do |req|
      # req.params['limit'] = 100
      # req.body = {email: 'salmon'}.to_json
    # end
    # result = JSON.parse(resp.body)
    # if result["status"] == "ok"
      # session[:authorized_user_id] = result["uuid"]
      # redirect_to(root_path, notice: 'Welcome back.')
    # else
      # redirect_to(new_session_path, notice: 'Sorry Check email / password.')
#
    # end
    #    payload = SecretBox.encrypt(payload).delete!("\n")

    client_id = URI::encode(ENV['STREAMING_CLIENT_ID'])

    response =
      Excon.post(
        "http://localhost:4000/api/v1/",
        :headers => {
          "Content-Type" => "application/json",
          "Api-Version" => "1.0",
          "Client-ID" => client_id
        },
        body: {payload: secret_payload}.to_json
      )

    Rails.logger.debug response.status == 200 # what if it went wrong??
    redirect_to(root_path)
  end












#  def create_on_network
#    encrypted_password = SecretBox.encrypt(user_params[:password]).delete!("\n")
#    encrypted_email = SecretBox.encrypt(user_params[:email]).delete!("\n")
#    encrypted_username = SecretBox.encrypt(user_params[:username]).delete!("\n")
#
#
#
#    payload = {
#        email: user_params[:email],
#        password: user_params[:password],
#        username: user_params[:username],
#        signature: ENV['CLIENT_SECRET']
#      }.to_json
#    payload = SecretBox.encrypt(payload).delete!("\n")
#
#    client_id = URI::encode(ENV['CLIENT_ID'])
#
#    response =
#      Excon.post(
#        "https://localhost:4008/api/users/",
#        :headers => {
#          "Content-Type" => "application/json",
#          "Api-Version" => "1.0",
#          "Client-ID" => client_id
#        },
#        body: {payload: payload}.to_json
#      )
#    Rails.logger.debug response.status == 200 # what if it went wrong??
#  end









  def destroy
    session[:authorized_user_id] = nil
    redirect_to root_path
  end
end
