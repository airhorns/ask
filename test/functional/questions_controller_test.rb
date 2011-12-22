require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = FactoryGirl.create(:question)
  end

  test "should get index" do
    sign_in @question.survey.customer
    get :index, format: :json, survey_id: @question.survey.to_param
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should create question" do
    sign_in @question.survey.customer
    assert_difference('Question.count') do
      post :create, survey_id: @question.survey.to_param, question: @question.attributes, format: :json
    end

    assert_response :success
    assert_not_nil assigns(:question)
  end

  test "should show question" do
    sign_in @question.survey.customer
    get :show, id: @question.to_param, format: :json
    assert_not_nil assigns(:question)
    assert_response :success
  end

  test "should show question stats" do
    sign_in @question.survey.customer
    get :stats, id: @question.to_param, format: :json
    assert_not_nil assigns(:question)
    assert_response :success
  end

  test "should update question" do
    sign_in @question.survey.customer
    put :update, id: @question.to_param, question: @question.attributes, format: :json
    assert_not_nil assigns(:question)
    assert_response :success
  end

  test "should destroy question" do
    sign_in @question.survey.customer
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question.to_param, format: :json
    end

    assert_response :success
  end

  test "shouldn't get index when not signed in" do
    get :index, format: :json, survey_id: @question.survey.to_param
    assert_response :unauthorized
  end

  test "shouldn't create question when not signed in" do
    post :create, survey_id: @question.survey.to_param, question: @question.attributes, format: :json
    assert_response :unauthorized
  end

  test "shouldn't show question when not signed in" do
    get :show, id: @question.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't show question stats when not signed in" do
    get :stats, id: @question.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't update question when not signed in" do
    put :update, id: @question.to_param, question: @question.attributes, format: :json
    assert_response :unauthorized
  end

  test "shouldn't destroy question when not signed" do
    delete :destroy, id: @question.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't get index when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    get :index, format: :json, survey_id: @question.survey.to_param
    assert_response :forbidden
  end

  test "shouldn't create question signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    post :create, survey_id: @question.survey.to_param, question: @question.attributes, format: :json
    assert_response :forbidden
  end

  test "shouldn't show question when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    get :show, id: @question.to_param, format: :json
    assert_response :forbidden
  end

  test "shouldn't show question stats when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    get :stats, id: @question.to_param, format: :json
    assert_response :forbidden
  end

  test "shouldn't update question when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    put :update, id: @question.to_param, question: @question.attributes, format: :json
    assert_response :forbidden
  end

  test "shouldn't destroy question when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    delete :destroy, id: @question.to_param, format: :json
    assert_response :forbidden
  end
end
