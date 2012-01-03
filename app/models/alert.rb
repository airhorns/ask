class Alert < ActiveRecord::Base
  belongs_to :subject, :polymorphic => true
  serialize :options
  validates_presence_of :subject

  after_initialize :set_empty_options

  scope :for_answer, lambda { |answer|
    includes(:subject).
      where("(subject_id = ? AND subject_type = 'Question') OR (subject_id = ? AND subject_type = 'Survey')",
            answer.question.id,
            answer.survey.id
           )
  }

  def check!(answer)
    raise NotImplementedException
  end


  def set_empty_options
    options ||= {}
  end
end
