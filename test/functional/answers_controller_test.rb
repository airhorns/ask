require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  setup do
    @answer = FactoryGirl.create(:answer)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:answers)
  end

  test "should show answer" do
    get :show, id: @answer.to_param
    assert_response :success
  end

  test "should destroy answer" do
    assert_difference('Answer.count', -1) do
      delete :destroy, id: @answer.to_param
    end

    assert_redirected_to answers_path
  end
end
