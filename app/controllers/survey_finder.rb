module SurveyFinder
  def find_and_authorize_survey!
    @survey = Survey.find(params[survey_id_params_key])
    authorize_survey(@survey)
  end

  def authorize_survey(survey)
    unless survey.customer == current_customer
      head :forbidden
    end
    false
  end

  private

  def survey_id_params_key
    :survey_id
  end

end
