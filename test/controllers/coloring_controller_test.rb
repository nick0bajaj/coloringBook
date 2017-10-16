require 'test_helper'

class ColoringControllerTest < ActionController::TestCase
  test "should get book" do
    get :book
    assert_response :success
  end

end
