class SurveySegmentsController < ApiController
  include SurveyFinder
  before_filter :find_and_authorize_survey!, :only => [:index, :new, :create]
  before_filter :find_and_authorize_segment!, :except => [:index, :new, :create]

  respond_to :json
  def index
    @survey_segments = @survey.segments.all
    respond_with(@survey_segments)
  end

  def show
    respond_with(@survey_segment)
  end

  def new
    @survey_segment = @survey.segments.build
    respond_with(@survey_segment)
  end

  def create
    @survey_segment = SurveySegment.new(params[:survey_segment])
    @survey_segment.survey = @survey
    flash[:notice] = 'SurveySegment was successfully created.' if @survey_segment.save
    respond_with(@survey_segment)
  end

  def update
    flash[:notice] = 'SurveySegment was successfully updated.' if @survey_segment.update_attributes(params[:survey_segment])
    respond_with(@survey_segment)
  end

  def destroy
    @survey_segment.destroy
    respond_with(@survey_segment)
  end

  private

  def find_and_authorize_segment!
    @survey_segment = SurveySegment.includes(:survey).find(params[:id])
    authorize_survey(@survey_segment.survey)
  end
end
