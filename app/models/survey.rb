class Survey < ActiveRecord::Base
  has_many :questions
  has_many :responses
  has_many :responders, :through => :responses
  belongs_to :customer

  scope :active, where(:active => true)
  scope :owned_by, ->(customer) { where(:customer_id => customer.id)}

  validates_presence_of :name, :phone_number, :active, :customer_id
  validates_associated :questions

  accepts_nested_attributes_for :questions

  attr_accessible :active, :name

  def as_json(options = {})
    super({:include => [:questions], :methods => [:current_week_responses_count, :previous_week_responses_count]}.merge(options))
  end

  def current_week_responses_count
    responses.where('created_at >= ?', 7.days.ago).count
  end

  def previous_week_responses_count
    responses.where("created_at >= ? AND created_at <= ?", 14.days.ago, 7.days.ago).count
  end

  def responses_count
    super || 0
  end
end
