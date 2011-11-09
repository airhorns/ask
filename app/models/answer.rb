class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :response
  has_one :rating, :class_name => 'AnswerMetaData', :conditions => {:key => 'rating'}
  validates_presence_of :question, :response, :text

  validates_associated :rating, :if => :rated?
  before_validation :build_rating_meta_data, :if => :rated?

  def numeric_rating
    rating.try(:value).to_i
  end

  def serializable_hash(options = {})
    if question.rated?
      super({:methods => [:numeric_rating, :rated?]}.merge(options))
    else
      super
    end
  end

  def parse_rating
    star_count = text.count("*#")
    if star_count > 0
      return star_count
    else
      return text.to_i
    end
  end

  def rate(value)
    if rating
      rating.value = value
    else
      build_rating(:value => value)
    end
  end

  def rated?
    question.rated?
  end

  private

  def build_rating_meta_data
    rate(parse_rating)
  end

end
