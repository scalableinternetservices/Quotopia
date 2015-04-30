require 'test_helper'

class QuotesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  fixtures :authors, :users

  setup do
    @quote = quotes(:one)
    @update = {
        content: "This is a new quote",
        author_attributes: {
            name: authors(:one)
        }
    }
    sign_in users(:lonelyguy)
  end

  test "should get index" do
    get :index
    assert_response :success
    # assert_not_nil assigns(:quotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quote" do
    assert_difference('Quote.count') do
      post :create, quote: @update
    end

    assert_redirected_to quote_path(assigns(:quote))
  end

  test "should show quote" do
    get :show, id: @quote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quote
    assert_response :success
  end

  test "should update quote" do
    patch :update, id: @quote, quote: @update
    assert_redirected_to quote_path(assigns(:quote))
  end

  test "should destroy quote" do
    assert_difference('Quote.count', -1) do
      delete :destroy, id: @quote
    end

    assert_redirected_to quotes_path
  end
end
