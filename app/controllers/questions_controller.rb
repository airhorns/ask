class QuestionsController < ApiController

  before_filter :authenticate_customer!
  before_filter :find_and_authorize_survey!, :only => [:index, :new, :create]

  def index
    @questions = @survey.questions.all
    respond_with @questions
  end

  def show
    @question = owned_questions.find(params[:id])
    respond_with @question
  end

  def stats
    @question = owned_questions.includes(:answers => :rating).find(params[:id])
    respond_with @question.stats
  end

  def new
    @question = @survey.questions.build
    respond_with @question
  end

  def create
    @question = @survey.questions.build(params[:question])
    @question.save
    respond_with @question
  end

  def update
    @question = owned_questions.find(params[:id])
    @question.update_attributes(params[:question])
    respond_with @question
  end

  def destroy
    @question = owned_questions.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  def find_and_authorize_survey!
    @survey = Survey.owned_by(current_customer).find(params[:survey_id])
  end

  def owned_questions
    Question.with_survey_owned_by(current_customer)
  end
end
