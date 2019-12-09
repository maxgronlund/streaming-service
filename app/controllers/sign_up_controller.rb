class SignUpController < ApplicationController
  def new
    # client_id = URI::encode(ENV['STREAMING_CLIENT_ID'])
    # redirect_to "http://localhost:4000/usr/signup/new?response_type=code&client_id=#{client_id}"
    redirect_url =
      ENV["BACKEND_URL"] +
      "oauth?response_type=code" +
      "&redirect_uri=#{ENV['STREAMING_CLIENT_HOST']}oauth_callback" +
      "&client_id=#{ENV['STREAMING_CLIENT_ID']}"
    # ap CGI.escape(redirect_uri)
    # #{ENV['STREAMING_CLIENT_ID']}/log_in/new

    #&redirect_uri=https%3A%2F%2Fs.typingclub.com%2Fm%2Fauth_callback.html&client_id=252994214745609&scope=email

    redirect_to URI::encode(redirect_url) # ENV["BACKEND_URL"] + "oauth?response_type=code"
  end
end
