require 'test_helper'

class ResponsesControllerTest < ActionController::TestCase
  setup do
    @response = FactoryGirl.create(:response)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:responses)
  end

  test "should show response" do
    get :show, id: @response.to_param
    assert_response :success
  end

  test "should destroy response" do
    assert_difference('Response.count', -1) do
      delete :destroy, id: @response.to_param
    end

    assert_redirected_to responses_path
  end
end
