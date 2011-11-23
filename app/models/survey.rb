class Survey < ActiveRecord::Base
  has_many :questions
  has_many :responses
  has_many :responders, :through => :responses
  accepts_nested_attributes_for :questions

  validates_presence_of :name, :phone_number, :active
  validates_associated :questions

  scope :active, where(:active => true)

  def as_json(options = {})
    super({:include => [:questions], :methods => [:current_week_responses_count, :previous_week_responses_count]}.merge(options))
  end

  def current_week_responses_count
    responses.where('created_at >= ?', 7.days.ago).count
  end

  def previous_week_responses_count
    responses.where("created_at >= ? AND created_at <= ?", 14.days.ago, 7.days.ago).count
  end
end
