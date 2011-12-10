require 'test_helper'

class RespondersControllerTest < ActionController::TestCase
  setup do
    @responder = FactoryGirl.create(:responder)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:responders)
  end

  test "should show responder" do
    get :show, id: @responder.to_param
    assert_response :success
  end

  test "should update responder" do
    put :update, id: @responder.to_param, responder: @responder.attributes
    assert_redirected_to responder_path(assigns(:responder))
  end
end
