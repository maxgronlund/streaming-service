# when the user click on a play button.
# there is a check to see if the user is signed in
# If not an Ajax call is send to bring up a dialog

class AuthenticateController < ApplicationController

  def open_dialog
    @dialog = "authenticate_dialog"
  end

  def user
    params.permit!

    conn = Faraday.new(
      url: 'http://localhost:4000/api/v1/',
      params: {email: params["email"], pass: params["password"]},
      headers: {'Content-Type' => 'application/json'}
    )

    resp = conn.get('users') do |req|
      # req.params['limit'] = 100
      # req.body = {email: 'salmon'}.to_json
    end
    result = JSON.parse(resp.body)
    if result["status"] == "ok"
      session[:authorized_user_id] = result["uuid"]
      @request_url = root_path
    else
      session[:authorized_user_id] = nil
    end
  end
end