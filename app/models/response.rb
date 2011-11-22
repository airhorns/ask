class Response < ActiveRecord::Base
  belongs_to :survey, :counter_cache => true
  belongs_to :responder
  has_many :questions, :through => :survey
  has_many :answers

  validates_presence_of :survey, :responder
  validates :complete, :inclusion => { :in => [true, false] }

  before_validation :set_completeness

  scope :complete, where(:complete => true)
  scope :incomplete, where(:complete => false)

  def self.for_survey_and_responder(survey, responder)
    attrs = {:survey_id => survey.id, :responder_id => responder.id}
    existing = self.incomplete.where(attrs).first
    if !existing.nil?
      existing
    else
      self.create(attrs)
    end
  end

  def unanswered_questions
    questions = survey.questions.order('"questions"."order"')
    if new_record?
      questions
    else
      questions
        .joins("LEFT OUTER JOIN answers ON answers.question_id = questions.id AND answers.response_id = #{id}")
        .where('answers.id IS NULL')
    end
  end

  def next_question
    unanswered_questions.first
  end

  def step!(text)
    return false unless persisted?
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

  def complete?
    check_completeness
  end

  private

  def answer_question!(question, text)
    result = question.answer!(self, text)
    if result
      set_completeness
      save! if changed?
    end
  end

  def check_completeness
    return (unanswered_questions.count == 0)
  end

  def set_completeness
    self.complete = check_completeness
    true
  end

end
