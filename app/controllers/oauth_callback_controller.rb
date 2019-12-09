class OauthCallbackController < ApplicationController
  def index

    params.permit!


    redirect_to root_path and return if params["token"] == "CANCEL"



    payload = {
        action: "GET_SESSION",
        token: params["token"]
      }.to_json

    response =
      Excon.post(
        ENV["BACKEND_API_URL"],
        :headers => {
          "Content-Type" => "application/json",
          "Api-Version" => "1.0",
          "Client-ID" => URI::encode(ENV['STREAMING_CLIENT_ID'])
        },
        body: {payload: SecretBox.encrypt(payload)}.to_json
      )
    # ap "response =====>"
    # ap JSON.parse(response.body)
    # ap response.status
    # ap "--------"
    case response.status
    when 200
      body = JSON.parse(response.body)
      user_id = body["user_id"]
      session[:authorized_user_id] = user_id
      redirect_to(root_path)
      # login(response) ? redirect_to(root_path) : redirect_to(new_session_path)
    when 401
      session[:authorized_user_id] = nil
      redirect_to(root_path, notice: '401 Unknown account.')
    else
      session[:authorized_user_id] = nil
      redirect_to(root_path, notice: "500 Unknown error")
    end


  end
end
