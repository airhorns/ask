module SurveyFinder
  def find_and_authorize_survey!
    @survey = Survey.owned_by(current_customer).find(params[survey_id_params_key])
  end

  def authorize_survey(survey)
    survey.customer == current_customer
  end

  private

  def survey_id_params_key
    :survey_id
  end

end
