require 'twilio-ruby'

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

  def start
    @survey = Survey.find(params[:id])
    return unless params[:phone_number]
    @client = Twilio::REST::Client.new Ask::Config['twilio']['sid'], Ask::Config['twilio']['token']
    @client.account.sms.messages.create(
      :from => "+17032913327",
      :to => "+1#{params[:phone_number]}",
      :body => @survey.questions.first.text
    )
    respond_to do |format|
      format.json { head :ok }
    end
  end
end
