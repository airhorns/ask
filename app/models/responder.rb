class Responder < ActiveRecord::Base
  has_many :answers
  validate :phone_number, :presence => true, :unique => true
end
