class AnswerMetaData < ActiveRecord::Base
  validates_presence_of :key, :value
  validates_numericality_of :value, {:greater_than => 0, :less_than => 6, :if => :is_rating? }

  def is_rating?
    key == 'rating'
  end
end
