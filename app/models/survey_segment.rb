class SurveySegment < ActiveRecord::Base
  belongs_to :survey
  validates_presence_of :phone_number, :name, :survey
  has_many :responses

  def self.for_phone_number(phone_number)
    includes(:survey)
      .where(:surveys => {:active => true})
      .first
  end
end
