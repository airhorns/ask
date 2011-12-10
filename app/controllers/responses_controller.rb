class ResponsesController < ApiController
  include SurveyFinder
  before_filter :find_and_authorize_survey!, :only => [:index]
  before_filter :find_response_and_authorize_survey, :except => [:index]

  def index
    @responses = @survey.responses
    .order('id DESC')
    .offset(params[:offset] || 0)
    .limit(params[:limit] || 25)
    .includes([
      {:survey => :questions},
      :responder,
      {:answers => [:question, :rating]}
    ])

    respond_with @responses
  end

  def show
    respond_with @response
  end

  def destroy
    @response.destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  def find_response_and_authorize_survey
    @response = Response.includes(:survey).find(params[:id])
    authorize_survey(@response.survey)
  end
end
