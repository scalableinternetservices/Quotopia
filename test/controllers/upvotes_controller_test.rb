require 'test_helper'

class UpvotesControllerTest < ActionController::TestCase
  setup do
    @upvote = upvotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:upvotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create upvote" do
    assert_difference('Upvote.count') do
      post :create, upvote: {  }
    end

    assert_redirected_to upvote_path(assigns(:upvote))
  end

  test "should show upvote" do
    get :show, id: @upvote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @upvote
    assert_response :success
  end

  test "should update upvote" do
    patch :update, id: @upvote, upvote: {  }
    assert_redirected_to upvote_path(assigns(:upvote))
  end

  test "should destroy upvote" do
    assert_difference('Upvote.count', -1) do
      delete :destroy, id: @upvote
    end

    assert_redirected_to upvotes_path
  end
end
