require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  fixtures :votes, :quotes, :users

  setup do
    @vote = votes(:upvote)
    @create = {
        value: 1,
        quote_id: quotes(:one),
        user_id: users(:quotopia)
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vote" do
    assert_difference('Vote.count') do
      post :create, vote: @create
    end

    assert_redirected_to vote_path(assigns(:vote))
  end

  test "should not create vote with same user_id and quote_id" do
 
   assert_no_difference('Vote.count') do
       post :create, vote: @vote
   end
  end

  test "should show vote" do
    get :show, id: @vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vote
    assert_response :success
  end

  test "should update vote" do
    patch :update, id: @vote, vote: { vote: { }  }
    assert_redirected_to vote_path(assigns(:vote))
  end

  test "should destroy vote" do
    assert_difference('Vote.count', -1) do
      delete :destroy, id: @vote
    end

    assert_redirected_to votes_path
  end
end
