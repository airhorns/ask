class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  has_many :responders, :through => :answers
  validates_presence_of :text, :order

  attr_accessible :text, :order

  include OwnedBySurvey

  def answer!(response, text)
    answer_for(response, text).save!
  end

  def rated?
    false
  end

  def as_json(options = {})
    super({:methods => [:rated?]}.merge(options))
  end

  def stats
    QuestionStats.new(self)
  end

  private

  def answer_for(response, text)
    answers.build(:question => self, :response => response, :text => text)
  end
end
