class Survey < ActiveRecord::Base
  has_many :questions
  has_many :responses
  has_many :responders, :through => :responses
  accepts_nested_attributes_for :questions

  validates_presence_of :name, :phone_number, :active
  validates_associated :questions

  scope :active, where(:active => true)

  def as_json(options = {})
    super({:include => [:questions]}.merge(options))
  end
end
