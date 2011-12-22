require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  setup do
    @answer = FactoryGirl.create(:answer)
  end

  test "should get index" do
    sign_in @answer.response.survey.customer
    get :index, response_id: @answer.response.to_param, format: :json
    assert_response :success
    assert_not_nil assigns(:answers)
  end

  test "should show answer" do
    sign_in @answer.response.survey.customer
    get :show, id: @answer.to_param, format: :json
    assert_response :success
    assert_not_nil assigns(:answer)
  end

  test "shouldn't show index when not signed in" do
    get :index, response_id: @answer.response.id, format: :json
    assert_response :unauthorized
  end

  test "shouldn't show index when signed in as a different customer" do
    sign_in FactoryGirl.create(:customer)
    get :index, response_id: @answer.response.id, format: :json
    assert_response :forbidden
  end

  test "shouldn't show answer when not signed in" do
    get :show, id: @answer.to_param, format: :json
    assert_response :unauthorized
  end

  test "shouldn't show answer to a different customer" do
    sign_in FactoryGirl.create(:customer)
    get :show, id: @answer.to_param, format: :json
    assert_response :forbidden
  end

  test "should destroy answer" do
    sign_in @answer.response.survey.customer
    assert_difference('Answer.count', -1) do
      delete :destroy, id: @answer.to_param, format: :json
    end

    assert_response :success
  end
end
