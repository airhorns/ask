class QuestionStats
  attr_reader :question
  def initialize(question)
    @question = question
  end

  def calculate_daily_distributions
    mapped = question.answers.reject {|a| a.created_at < 7.days.ago}.reduce({}) do |acc, answer|
      key = answer.created_at.day
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
    mapped = question.answers.reject {|a| a.created_at < 30.days.ago}.reduce({}) do |acc, answer|
      key = answer.created_at.strftime("%j")
      acc[key] ||= []
      acc[key].push answer.numeric_rating.to_i
      acc
    end

    mapped.each do |day, ratings|
      mapped[day] = ratings.sum.to_f / ratings.size
    end
  end

  def as_json(options = {})
    unless question.rated?
      {}
    else
      {'daily' => calculate_daily_distributions, 'monthly' => calculate_monthly_trend}
    end
  end
end
