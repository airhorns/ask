class Response < ActiveRecord::Base
  belongs_to :survey
  belongs_to :responder
  has_many :questions, :through => :survey
  has_many :answers

  validates_presence_of :survey, :responder

  def self.for(survey, responder)
    attrs = {:survey_id => survey.id, :responder_id => responder.id}
    existing = self.where(attrs).first
    if !existing.nil?
      existing
    else
      self.create(attrs)
    end
  end

  def unanswered_questions
    survey.questions.joins("LEFT OUTER JOIN answers ON answers.question_id = questions.id AND answers.responder_id = #{responder.id}").where('answers.id IS NULL')
  end

  def next_question
    unanswered_questions.first
  end

  def step!(text)
    unanswered_question = next_question
    if unanswered_question
      answer_question!(unanswered_question, text)
      true
    else
      false
    end
  end

  private

  def answer_question!(question, text)
    question.answers.create!(:responder => responder, :question => question, :response => self, :text => text)
  end

end
