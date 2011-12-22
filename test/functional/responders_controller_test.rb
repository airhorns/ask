require 'test_helper'

class RespondersControllerTest < ActionController::TestCase
  setup do
    @responder = FactoryGirl.create(:responder)
    @customer = FactoryGirl.create(:customer)
  end

  test "should get index" do
    sign_in @customer
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:responders)
  end

  test "should show responder" do
    sign_in @customer
    get :show, id: @responder.to_param, format: :json
    assert_response :success
  end

  test "should update responder" do
    sign_in @customer
    put :update, id: @responder.to_param, responder: @responder.attributes, format: :json
    assert_response :success
  end

  test "shouldn't get index when not signed in" do
    get :index, format: :json
    assert_response :unauthorized
  end

  test "shouldn't show responder when not signed in" do
    get :show, id: @responder.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't update responder when not signed in" do
    put :update, id: @responder.to_param, responder: @responder.attributes, format: :json
    assert_response :unauthorized
  end
end
