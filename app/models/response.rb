class Response < ActiveRecord::Base
  belongs_to :responder
  has_many :answers, :dependent => :destroy

  belongs_to :segment, :counter_cache => true, :class_name => 'SurveySegment', :foreign_key => :survey_segment_id
  has_one :survey, :through => :segment
  has_many :questions, :through => :survey

  validates_presence_of :segment, :responder
  validates :complete, :inclusion => { :in => [true, false] }

  before_validation :set_completeness

  scope :complete, where(:complete => true)
  scope :incomplete, where(:complete => false)
  scope :recent, ->(limit) { includes(:survey => :customer).order(:created_at).limit(limit) }
  scope :including_survey, includes({:segment => {:survey => :questions}})
  scope :including_answers, includes([:responder, {:answers => [:question, :rating]}])


  include OwnedBySurvey

  def self.for_segment_and_responder(segment, responder)
    attrs = {:survey_segment_id => segment.id, :responder_id => responder.id}
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

  def step(text)
    return unless persisted?
    unanswered_question = next_question
    if unanswered_question
      unanswered_question.answer_for(self, text)
    end
  end

  def as_json(options = {})
    super({:include => [:answers, :responder]}.merge(options))
  end

  def complete?
    check_completeness
  end

  def set_completeness
    self.complete = check_completeness
    true
  end

  def answer_for_question(question)
    answers.where(:question_id => question).first
  end

  private

  def check_completeness
    return (unanswered_questions.count == 0)
  end
end
