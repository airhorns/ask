class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  validates_presence_of :text

  scope :unanswered_by, ->(responder) { joins("LEFT OUTER JOIN answers ON answers.question_id = questions.id AND answers.responder_id = #{responder.id}").where('answers.id IS NULL')}
end
