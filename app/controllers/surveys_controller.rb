class SurveysController < ApplicationController
  respond_to :json

  def index
    @surveys = Survey.all
    respond_with @surveys
  end

  def show
    @survey = Survey.find(params[:id])
    respond_with @survey
  end

  def new
    @survey = Survey.new
    respond_with @survey
  end

  def edit
    @survey = Survey.find(params[:id])
    respond_with @survey
  end

  def create
    @survey = Survey.new(params[:survey])
    @survey.save
    respond_with @survey
  end

  def update
    @survey = Survey.find(params[:id])
    @survey.update_attributes(params[:survey])
    respond_with @survey
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end
end
