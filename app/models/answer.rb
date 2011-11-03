class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :responder
  belongs_to :response

  validates_presence_of :question, :responder, :response, :text
end
