require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  fixtures :users

  setup do
    @create = {
        message: "twitter"
    }
    sign_in users(:lonelyguy)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should get create" do
  #   post :create, message: @create
  #   assert_response :success
  # end

end
