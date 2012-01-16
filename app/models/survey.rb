class Survey < ActiveRecord::Base
  belongs_to :customer
  has_many :questions
  has_many :segments, :class_name => 'SurveySegment'
  has_many :responses, :through => :segments
  has_many :responders, :through => :responses
  has_many :alerts, :as => :subject

  scope :active, where(:active => true)
  scope :owned_by, ->(customer) { where(:customer_id => customer.id)}

  validates_presence_of :name, :active, :customer_id, :finish_message
  validates_associated :questions

  accepts_nested_attributes_for :questions

  attr_accessible :active, :name, :customer_id, :finish_message

  def phone_number
    segments.first.phone_number
  end

  def as_json(options = {})
    super({:include => [:questions, :segments], :methods => [:current_week_responses_count, :previous_week_responses_count]}.merge(options))
  end

  def current_week_responses_count
    responses.where('responses.created_at >= ?', 7.days.ago).count
  end

  def previous_week_responses_count
    responses.where("responses.created_at >= ? AND responses.created_at <= ?", 14.days.ago, 7.days.ago).count
  end

  def responses_count
    super || 0
  end
end
