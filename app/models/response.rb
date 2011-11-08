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
    survey.questions.joins("LEFT OUTER JOIN answers ON answers.question_id = questions.id AND answers.response_id = #{id}").where('answers.id IS NULL')
  end

  def next_question
    unanswered_questions.order('"questions"."order"').first
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

  def as_json(options = {})
    super({:include => [:answers, :responder]}.merge(options))
  end

  private

  def answer_question!(question, text)
    question.answer!(self, text)
  end

end
