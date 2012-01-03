class RunAlertsJob
  @queue = 'alerts'

  def self.perform(answer_id)
    answer = Answer.includes(:question, :survey).find(answer_id)
    return true unless answer.present?
    Alert.for_answer(answer).each do |alert|
      alert.check!(answer)
    end
  end
end
