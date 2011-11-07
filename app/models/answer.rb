class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :response
  has_many :meta_datas, :class_name => 'AnswerMetaData', :dependent => :destroy
  has_many :ratings, :class_name => 'AnswerMetaData', :conditions => {:key => 'rating'}
  validates_presence_of :question, :response, :text
  validates_associated :meta_datas

  def rate(text_rating)
    rating = ratings.build(:value => text_rating)
    ratings << rating
    rating
  end

  def rating
    if ratings.length > 0
      ratings.first.value
    end
  end

  def as_json(options = {})
    default_options = {}
    if question.rated?
      default_options[:methods] = [:rating]
    end
    super(default_options.merge(options))
  end
end
