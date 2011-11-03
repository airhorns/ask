class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :responder

  validates_presence_of :question, :responder, :text
end
