class QuestionStats
  attr_reader :question
  def initialize(question)
    @question = question
  end

  def calculate_daily_distributions
    mapped = @question.answers.before(7.days.ago).reduce({}) do |acc, answer|
      key = answer.created_at.beginning_of_day
      if acc[key].nil?
        acc[key] = {}
        1.upto(5) do |i|
          acc[key][i] = 0
        end
      end

      rating = answer.numeric_rating.to_i
      acc[key][rating] += 1
      acc
    end
  end

  def calculate_monthly_trend
    mapped = @question.answers.before(30.days.ago).reduce({}) do |acc, answer|
      key = answer.created_at.beginning_of_day
      acc[key] ||= []
      acc[key].push answer.numeric_rating.to_i
      acc
    end

    mapped.each do |day, ratings|
      mapped[day] = ratings.sum.to_f / ratings.size
    end
  end

  def calculate_current_week_average
    ratings = @question.answers.before(7.days.ago).map(&:numeric_rating)
    ratings.sum.to_f / ratings.size
  end

  def calculate_previous_week_average
    ratings = @question.answers.between(14.days.ago, 7.days.ago).map(&:numeric_rating)
    ratings.sum.to_f / ratings.size
  end

  def as_json(options = {})
    unless @question.rated?
      {}
    else
      {
        'daily' => calculate_daily_distributions,
        'monthly' => calculate_monthly_trend,
        'current_week_average' => calculate_current_week_average,
        'previous_week_average' => calculate_previous_week_average
      }
    end
  end
end
