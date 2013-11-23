require 'test_helper'

class DonateControllerTest < ActionController::TestCase
  test "should get landing" do
    get :landing
    assert_response :success
  end

  test "should get thanks" do
    get :thanks
    assert_response :success
  end

end
