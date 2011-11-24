module OwnedBySurvey
  def self.included(base)
    base.class_eval do
      scope :with_survey_owned_by, ->(customer) { includes(:survey).where(:surveys => {:customer_id => customer.id})}
    end
  end
end
