class Alert < ActiveRecord::Base
  belongs_to :survey

  validates_presence_of :survey_id

  after_initialize :set_empty_options

  def check!(answer)
    raise NotImplementedException
  end

  before_save :marshal_options
  after_find :load_options

  private

  def marshal_options
    options = ActiveSupport::JSON.encode(options)
    true
  end

  def load_options
    debugger
    unless options.nil? || options.blank?
      options = ActiveSupport::JSON.decode(options)
    end
    true
  end

  def set_empty_options
    options ||= {}
  end
end
