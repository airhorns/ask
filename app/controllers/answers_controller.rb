class AnswersController < ApiController
  before_filter :find_and_authorize_response!

  def index
    @answers = Response.find(params[:response_id]).answers
    respond_with @answers
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  def find_and_authorize_response!
    @response = Reponse.with_survey_owned_by(current_customer).find(params[:response_id])
  end
end
