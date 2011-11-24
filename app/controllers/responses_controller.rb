class ResponsesController < ApiController
  include SurveyFinder
  before_filter :find_and_authorize_survey!

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
    @response = @survey.find(params[:id])
    respond_with @response
  end

  def destroy
    @response = @survey.find(params[:id])
    @response.destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

end
