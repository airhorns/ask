require 'test_helper'

class ResponsesControllerTest < ActionController::TestCase
  setup do
    @a_response = FactoryGirl.create(:response)
  end

  test "should get index" do
    sign_in @a_response.survey.customer
    get :index, format: :json, survey_id: @a_response.survey.to_param
    assert_response :success
    assert_not_nil assigns(:responses)
  end

  test "should show response" do
    sign_in @a_response.survey.customer
    get :show, id: @a_response.to_param, format: :json
    assert_response :success
  end

  test "should destroy response" do
    sign_in @a_response.survey.customer
    assert_difference('Response.count', -1) do
      delete :destroy, id: @a_response.to_param, format: :json
    end

    assert_response :success
  end

  test "shouldn't get index when not signed in" do
    get :index, format: :json, survey_id: @a_response.survey.to_param
    assert_response :unauthorized
  end

  test "shouldn't show response when not signed in" do
    get :show, id: @a_response.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't destroy response when not signed in" do
    assert_no_difference('Response.count') do
      delete :destroy, id: @a_response.to_param, format: :json
    end

    assert_response :unauthorized
  end

  test "shouldn't get index when signed in as a different user" do
    sign_in FactoryGirl.create(:customer)
    get :index, format: :json, survey_id: @a_response.survey.to_param
    assert_response :forbidden
  end

  test "shouldn't show response when signed in as a different user" do
    sign_in FactoryGirl.create(:customer)
    get :show, id: @a_response.to_param, format: :json
    assert_response :forbidden
  end

  test "shouldn't destroy response when signed in as a different user" do
    sign_in FactoryGirl.create(:customer)
    assert_no_difference('Response.count') do
      delete :destroy, id: @a_response.to_param, format: :json
    end

    assert_response :forbidden
  end
end
