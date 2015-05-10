require 'test_helper'

class FavoriteQuotesControllerTest < ActionController::TestCase
  setup do
    @favorite_quote = favorite_quotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:favorite_quotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create favorite_quote" do
    assert_difference('FavoriteQuote.count') do
      post :create, favorite_quote: { quote_id: @favorite_quote.quote_id, user_id: @favorite_quote.user_id }
    end

    assert_redirected_to favorite_quote_path(assigns(:favorite_quote))
  end

  test "should show favorite_quote" do
    get :show, id: @favorite_quote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @favorite_quote
    assert_response :success
  end

  test "should update favorite_quote" do
    patch :update, id: @favorite_quote, favorite_quote: { quote_id: @favorite_quote.quote_id, user_id: @favorite_quote.user_id }
    assert_redirected_to favorite_quote_path(assigns(:favorite_quote))
  end

  test "should destroy favorite_quote" do
    assert_difference('FavoriteQuote.count', -1) do
      delete :destroy, id: @favorite_quote
    end

    assert_redirected_to favorite_quotes_path
  end
end
