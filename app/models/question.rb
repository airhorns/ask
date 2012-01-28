class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers, :dependent => :destroy
  has_many :responders, :through => :answers
  has_many :alerts, :as => :subject
  validates_presence_of :text, :order, :survey

  attr_accessible :text, :order

  include OwnedBySurvey

  def rated?
    false
  end

  def stats
    @stats ||= QuestionStats.new(self)
    @stats
  end

  def answer_rate
    rate = ((answers_count || 0).to_f / survey.responses.count)
    if rate.nan?
      0
    else
      rate
    end
  end

  def answers_count
    super || 0
  end

  def answer_for(response, text)
    answers.build(:question => self, :response => response, :text => text)
  end

  def as_json(options = {})
    super({:methods => [:answer_rate]}.merge(options))
  end

  def duplicate
    new_question = self.class.new(text: text, order: order)
  end
end
