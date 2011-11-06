class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :response

  validates_presence_of :question, :response, :text
end
