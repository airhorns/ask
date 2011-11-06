require 'test_helper'

class RespondersControllerTest < ActionController::TestCase
  setup do
    @responder = responders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:responders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create responder" do
    assert_difference('Responder.count') do
      post :create, responder: @responder.attributes
    end

    assert_redirected_to responder_path(assigns(:responder))
  end

  test "should show responder" do
    get :show, id: @responder.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @responder.to_param
    assert_response :success
  end

  test "should update responder" do
    put :update, id: @responder.to_param, responder: @responder.attributes
    assert_redirected_to responder_path(assigns(:responder))
  end

  test "should destroy responder" do
    assert_difference('Responder.count', -1) do
      delete :destroy, id: @responder.to_param
    end

    assert_redirected_to responders_path
  end
end
