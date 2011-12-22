class QuestionsController < ApiController
  include SurveyFinder
  before_filter :authenticate_customer!
  before_filter :find_and_authorize_survey!, :only => [:index, :new, :create]
  before_filter :find_and_authorize_question!, :except => [:index, :new, :create]

  def index
    @questions = @survey.questions.all
    respond_with @questions
  end

  def show
    respond_with @question
  end

  def stats
    @answers = @question.answers.includes(:rating).all
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
    @question.update_attributes(params[:question])
    respond_with @question
  end

  def destroy
    @question.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  def find_and_authorize_question!
    @question = Question.includes(:survey).find(params[:id])
    authorize_survey(@question.survey)
  end
end
