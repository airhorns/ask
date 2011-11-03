class Responder < ActiveRecord::Base
  has_many :answers

  def answer_question!(question, text)
    question.answers.create!(:responder => self, :text => text)
  end
end
