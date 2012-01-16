require 'test_helper'

class SurveySegmentsControllerTest < ActionController::TestCase
  def setup
    @survey_segment = FactoryGirl.create(:survey_segment)
  end

  test "should get index" do
    sign_in @survey_segment.survey.customer
    get :index, format: :json, survey_id: @survey_segment.survey.to_param
    assert_response :success
    assert_not_nil assigns(:survey_segments)
  end

  test "should create survey_segment" do
    sign_in @survey_segment.survey.customer
    assert_difference('SurveySegment.count') do
      post :create, survey_id: @survey_segment.survey.to_param, survey_segment: @survey_segment.attributes, format: :json
    end

    assert_response :success
    assert_not_nil assigns(:survey_segment)
  end

  test "should show survey_segment" do
    sign_in @survey_segment.survey.customer
    get :show, id: @survey_segment.to_param, format: :json
    assert_not_nil assigns(:survey_segment)
    assert_response :success
  end

  test "should update survey_segment" do
    sign_in @survey_segment.survey.customer
    put :update, id: @survey_segment.to_param, survey_segment: @survey_segment.attributes, format: :json
    assert_not_nil assigns(:survey_segment)
    assert_response :success
  end

  test "should destroy survey_segment" do
    sign_in @survey_segment.survey.customer
    assert_difference('SurveySegment.count', -1) do
      delete :destroy, id: @survey_segment.to_param, format: :json
    end

    assert_response :success
  end

  test "shouldn't get index when not signed in" do
    get :index, format: :json, survey_id: @survey_segment.survey.to_param
    assert_response :unauthorized
  end

  test "shouldn't create survey_segment when not signed in" do
    post :create, survey_id: @survey_segment.survey.to_param, survey_segment: @survey_segment.attributes, format: :json
    assert_response :unauthorized
  end

  test "shouldn't show survey_segment when not signed in" do
    get :show, id: @survey_segment.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't update survey_segment when not signed in" do
    put :update, id: @survey_segment.to_param, survey_segment: @survey_segment.attributes, format: :json
    assert_response :unauthorized
  end

  test "shouldn't destroy survey_segment when not signed" do
    delete :destroy, id: @survey_segment.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't get index when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    get :index, format: :json, survey_id: @survey_segment.survey.to_param
    assert_response :forbidden
  end

  test "shouldn't create survey_segment signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    post :create, survey_id: @survey_segment.survey.to_param, survey_segment: @survey_segment.attributes, format: :json
    assert_response :forbidden
  end

  test "shouldn't show survey_segment when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    get :show, id: @survey_segment.to_param, format: :json
    assert_response :forbidden
  end

  test "shouldn't update survey_segment when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    put :update, id: @survey_segment.to_param, survey_segment: @survey_segment.attributes, format: :json
    assert_response :forbidden
  end

  test "shouldn't destroy survey_segment when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    delete :destroy, id: @survey_segment.to_param, format: :json
    assert_response :forbidden
  end
end
