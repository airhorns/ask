class Responder < ActiveRecord::Base
  has_many :answers
  has_many :responses, :dependent => :destroy
  validate :phone_number, :presence => true, :unique => true
end
