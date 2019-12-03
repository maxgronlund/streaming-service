class AuthorizeController < ApplicationController

  # called with Ajax from the player.js when there is an authorized user
  def track
    params.permit!


    conn = Faraday.new(
      url: 'http://localhost:4000/api/v1/',
      params: {
        user_uuid: session[:authorized_user_id],
        work_uuid: params["work_id"],
        track_uuid: params["track_id"]
      },
      headers: { 'Content-Type' => 'application/json' }
    )

    resp = conn.get('track_uri') do |req|
      # req.params['limit'] = 100
      # req.body = {email: 'salmon'}.to_json
    end
    result = JSON.parse(resp.body)


    if result["status"] == "ok"
      @audio_uri = result["audio_uri"]
      @track_uuid = result["track_uuid"]
    else

    end
  end
end