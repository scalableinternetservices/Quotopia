require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  fixtures :quotes, :users

  setup do
    @comment = comments(:one)
    @update = {
        content: "This is a new comment",
    }
    sign_in users(:lonelyguy)
  end

  test "should get index" do
    get :index, :quote_id => quotes(:one)
    assert_response :success
  end

  test "should get new" do
    get :new, :quote_id => quotes(:one)
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: @update, quote_id: quotes(:one)
    end

    assert_redirected_to quote_path(quotes(:one))
  end

  test "should show comment" do
    get :show, :quote_id => quotes(:one), id: @comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, :quote_id => quotes(:one), id: @comment
    assert_response :success
  end

  test "should update comment" do
    patch :update, :quote_id => quotes(:one), id: @comment, comment: @update
    assert_redirected_to quote_path(quotes(:one))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :quote_id => quotes(:one), id: @comment
    end

    assert_redirected_to quote_path(quotes(:one))
  end
end
