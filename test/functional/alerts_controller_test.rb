require 'test_helper'

class AlertsControllerTest < ActionController::TestCase
  setup do
    @alert = FactoryGirl.create(:contains_word_alert_on_survey)
  end

  test "should get index" do
    sign_in @alert.subject.customer
    get :index, format: :json, survey_id: @alert.subject.to_param
    assert_response :success
    assert_not_nil assigns(:alerts)
  end

  test "should create alert on survey" do
    sign_in @alert.subject.customer
    assert_difference('Alert.count') do
      post :create, survey_id: @alert.subject.to_param, alert: @alert.attributes, format: :json
    end

    assert_response :success
    assert_not_nil assigns(:alert)
  end

  test "should create alert on question" do
    @alert = FactoryGirl.build(:contains_word_alert_on_question)
    sign_in @alert.subject.survey.customer
    @question = @alert.subject
    assert_difference('Alert.count') do
      post :create, question_id: @alert.subject.to_param, alert: @alert.attributes, format: :json
    end

    assert_response :success
    assert_not_nil assigns(:alert)
  end

  test "should show alert" do
    sign_in @alert.subject.customer
    get :show, id: @alert.to_param, format: :json
    assert_not_nil assigns(:alert)
    assert_response :success
  end

  test "should update alert" do
    sign_in @alert.subject.customer
    put :update, id: @alert.to_param, alert: @alert.attributes, format: :json
    assert_not_nil assigns(:alert)
    assert_response :success
  end

  test "should destroy alert" do
    sign_in @alert.subject.customer
    assert_difference('Alert.count', -1) do
      delete :destroy, id: @alert.to_param, format: :json
    end

    assert_response :success
  end

  test "shouldn't get index when not signed in" do
    get :index, format: :json, survey_id: @alert.subject.to_param
    assert_response :unauthorized
  end

  test "shouldn't create alert on survey when not signed in" do
    post :create, survey_id: @alert.subject.to_param, alert: @alert.attributes, format: :json
    assert_response :unauthorized
  end

  test "shouldn't create alert on question when not signed in" do
    @alert = FactoryGirl.build(:contains_word_alert_on_question)
    post :create, question_id: @alert.subject.to_param, alert: @alert.attributes, format: :json
    assert_response :unauthorized
  end

  test "shouldn't show alert when not signed in" do
    get :show, id: @alert.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't update alert when not signed in" do
    put :update, id: @alert.to_param, alert: @alert.attributes, format: :json
    assert_response :unauthorized
  end

  test "shouldn't destroy alert when not signed" do
    delete :destroy, id: @alert.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't get index when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    get :index, format: :json, survey_id: @alert.subject.to_param
    assert_response :forbidden
  end

  test "shouldn't create alert on survey when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    post :create, survey_id: @alert.subject.to_param, alert: @alert.attributes, format: :json
    assert_response :forbidden
  end

  test "shouldn't create alert on question when signed in as a different customer" do
    @alert = FactoryGirl.build(:contains_word_alert_on_question)
    sign_in FactoryGirl.create(:customer)
    post :create, question_id: @alert.subject.to_param, alert: @alert.attributes, format: :json
    assert_response :forbidden
  end

  test "shouldn't show alert when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    get :show, id: @alert.to_param, format: :json
    assert_response :forbidden
  end

  test "shouldn't update alert when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    put :update, id: @alert.to_param, alert: @alert.attributes, format: :json
    assert_response :forbidden
  end

  test "shouldn't destroy alert when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    delete :destroy, id: @alert.to_param, format: :json
    assert_response :forbidden
  end
end
