class QuestionsController < ApplicationController
  respond_to :json
  def index
    @questions = Question.where(:survey_id => params[:survey_id]).all
    respond_with @questions
  end

  def show
    @question = Question.find(params[:id])
    respond_with @question
  end

  def new
    @question = Question.new(:survey_id => params[:survey_id])
    respond_with @question
  end

  def create
    @question = Question.new(params[:question])
    @question.save
    respond_with @question
  end

  def update
    @question = Question.find(params[:id])
    @question.update_attributes(params[:question])
    respond_with @question
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end
end
