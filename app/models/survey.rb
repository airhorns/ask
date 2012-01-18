class Survey < ActiveRecord::Base
  belongs_to :customer
  has_many :questions
  has_many :segments, :class_name => 'SurveySegment'
  has_many :responses, :through => :segments
  has_many :responders, :through => :responses
  has_many :answers, :through => :responses
  has_many :alerts, :as => :subject

  scope :active, where(:active => true)
  scope :owned_by, ->(customer) { where(:customer_id => customer.id)}

  validates_presence_of :name, :active, :customer_id, :finish_message
  validates_associated :questions

  accepts_nested_attributes_for :questions, :segments

  attr_accessible :active, :name, :customer_id, :finish_message

  def first_phone_number
    segments.first.phone_number
  end

  def as_json(options = {})
    super({:include => {
            :questions => {:methods => []},
            :segments => {:methods => []}
          },
          :methods => [:stats]
    }.merge(options))
  end

  def responses_count
    super || 0
  end

  def stats
    @stats ||= SurveyStats.new(self)
    @stats
  end
end
