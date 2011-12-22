class RunAlertsJob
  @queue = 'alerts'

  def self.perform(answer_id)
    answer = Answer.includes(:survey).find(answer_id)
    answer.survey.alerts.each do |alert|
      alert.check!(answer)
    end
  end
end
