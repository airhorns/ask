require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  setup do
    @survey = FactoryGirl.create(:survey)
    @customer = @survey.customer
  end

  test "should get index" do
    sign_in @survey.customer
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  test "should get new" do
    sign_in @survey.customer
    get :new, format: :json
    assert_response :success
  end

  test "should create survey" do
    sign_in @survey.customer
    survey_attributes = FactoryGirl.attributes_for(:survey, :customer => nil)
    assert_difference('Survey.count') do
      post :create, survey: survey_attributes, format: :json
    end
    assert_response :success
  end

  test "should show survey" do
    sign_in @survey.customer
    get :show, id: @survey.to_param, format: :json
    assert_response :success
  end

  test "should update survey" do
    sign_in @survey.customer
    put :update, id: @survey.to_param, survey: @survey.attributes, format: :json
    assert_response :success
  end

  test "should destroy survey" do
    sign_in @survey.customer
    assert_difference('Survey.count', -1) do
      delete :destroy, id: @survey.to_param, format: :json
    end
    assert_response :success
  end

  test "shouldn't get index when not signed in" do
    get :index, format: :json
    assert_response :unauthorized
  end

  test "shouldn't get new when not signed in" do
    get :new, format: :json
    assert_response :unauthorized
  end

  test "shouldn't create survey when not signed in" do
    assert_no_difference('Survey.count') do
      post :create, survey: @survey.attributes, format: :json
      assert_response :unauthorized
    end
  end

  test "shouldn't show survey when not signed in" do
    get :show, id: @survey.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't update survey when not signed in" do
    put :update, id: @survey.to_param, survey: @survey.attributes, format: :json
    assert_response :unauthorized
  end

  test "shouldn't destroy survey when not signed in" do
    assert_no_difference('Survey.count') do
      delete :destroy, id: @survey.to_param, format: :json
    end
    assert_response :unauthorized
  end

  test "shouldn't get index when signed in as a different user" do
    sign_in FactoryGirl.create(:customer)
    get :index, format: :json
    assert_response :success
    assert_empty assigns(:surveys)
  end

  test "shouldn't show survey when signed in as a different user" do
    sign_in FactoryGirl.create(:customer)
    get :show, id: @survey.to_param, format: :json
    assert_response :forbidden
  end

  test "shouldn't update survey when signed in as a different user" do
    other_customer = FactoryGirl.create(:customer)
    sign_in other_customer
    assert_not_equal other_customer, @customer
    put :update, id: @survey.to_param, survey: @survey.attributes, format: :json
    assert_response :forbidden
  end

  test "shouldn't destroy survey when signed in as a different user" do
    sign_in FactoryGirl.create(:customer)
    assert_no_difference('Survey.count') do
      delete :destroy, id: @survey.to_param, format: :json
    end
    assert_response :forbidden
  end
end
