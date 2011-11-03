class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  validates_presence_of :text
end
