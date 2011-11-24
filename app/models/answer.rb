class Answer < ActiveRecord::Base
  belongs_to :question, :counter_cache => true
  belongs_to :response
  has_one :rating, :class_name => 'AnswerMetaData', :conditions => {:key => 'rating'}
  has_many :meta_datas, :class_name => 'AnswerMetaData'
  validates_presence_of :question, :response, :text

  validates_associated :rating, :if => :rated?
  before_validation :build_rating_meta_data, :if => :rated?

  scope :before, ->(before) {
    scoped
      .includes(:rating)
      .where('created_at >= ?', before.to_date)
  }

  scope :after, ->(after) {
    scoped
      .includes(:rating)
      .where('created_at <= ?', after.to_date)
  }

  scope :between, ->(before, after) { scoped.before(before).after(after) }

  def numeric_rating
    value = rating.try(:value).to_i
    if value.to_f.nan?
      0
    else
      value
    end
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
