class AlertsController < ApiController
  include SurveyFinder
  before_filter :find_and_authorize_subject!, :only => [:index, :new, :create]
  before_filter :find_and_authorize_alert!, :except => [:index, :new, :create]

  def index
    @alerts = Alert.for_survey(@survey)
    respond_with @alerts
  end

  def show
    respond_with @alert
  end

  def new
    @alert = @subject.alerts.build
    respond_with @alert
  end

  def create
    @alert = @subject.alerts.build(params[:alert])
    @alert.type = 'ContainsWordAlert'
    @alert.save
    respond_with @alert
  end

  def update
    @alert.update_attributes(params[:alert])
    respond_with @alert
  end

  def destroy
    @alert.destroy
    respond_with @alert
  end

  private

  def find_and_authorize_subject!
    if params[:survey_id].present?
      @survey = Survey.find(params[:survey_id])
      @subject = @survey
    elsif params[:question_id].present?
      @subject = Question.includes(:survey).find(params[:question_id])
      @survey = @subject.survey
    else
      render :status => :not_found
      return false
    end
    authorize_survey(@survey)
  end

  def find_and_authorize_alert!
    @alert = Alert.includes(:subject).find(params[:id])
    if @alert.subject.is_a?(Survey)
      @survey = @alert.subject
    elsif @alert.subject.present? && @alert.subject.survey.present?
      @survey = @alert.subject
    else
      render :status => :not_found
      return false
    end
    authorize_survey(@survey)
  end
end
