require 'test_helper'

class OauthCallbackControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get oauth_callback_index_url
    assert_response :success
  end

end
