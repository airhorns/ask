class Alert < ActiveRecord::Base
  belongs_to :survey
  serialize :options
  validates_presence_of :survey_id

  after_initialize :set_empty_options

  def check!(answer)
    raise NotImplementedException
  end


  def set_empty_options
    options ||= {}
  end
end
