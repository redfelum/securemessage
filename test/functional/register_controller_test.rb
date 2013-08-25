require 'test_helper'

class RegisterControllerTest < ActionController::TestCase
  test "should get callback" do
    get :callback
    assert_response :success
  end

  test "should get failure" do
    get :failure
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
