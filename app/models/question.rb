class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  validates_presence_of :text, :order

  def answer!(response, text)
    answers.create!(:question => self, :response => response, :text => text)
  end
end
