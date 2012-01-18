class SurveyStats < StatsCalculator
  AVERAGE_WEEKLY_RATING_QUERY = <<-eos
    SELECT
      EXTRACT(EPOCH FROM date_trunc('day', "answers".created_at)) as x,
      AVG(cast("answer_meta_data"."value" as int)) as y
    FROM "answer_meta_data"
      INNER JOIN "answers" ON "answer_meta_data"."answer_id" = "answers"."id"
      INNER JOIN "responses" ON "answers"."response_id" = "responses"."id"
      INNER JOIN "survey_segments" ON "responses"."survey_segment_id" = "survey_segments"."id"
    WHERE "survey_segments"."survey_id" = ? AND ("answer_meta_data"."key" = 'rating')
    GROUP BY date_trunc('day', "answers"."created_at")
    ORDER BY x
  eos

  def initialize(survey)
    @survey = survey
  end

  def total_responses
    @survey.responses.count
  end

  def current_week_responses_count
    @survey.responses.where('responses.created_at >= ?', 7.days.ago).count
  end

  def previous_week_responses_count
    @survey.responses.where("responses.created_at >= ? AND responses.created_at <= ?", 14.days.ago, 7.days.ago).count
  end

  def current_week_average_rating
    weekly_average_rating[weekly_average_rating.size - 1][:y]
  end

  def previous_week_average_rating
    weekly_average_rating[weekly_average_rating.size - 2][:y]
  end

  def weekly_average_rating
    @weekly_ratings ||= cast_to_numeric_on_date(execute(AVERAGE_WEEKLY_RATING_QUERY, @survey.id))
    @weekly_ratings
  end

  def as_json(options = {})
    hash = {}
    %w{total_responses current_week_responses_count previous_week_responses_count current_week_average_rating previous_week_average_rating weekly_average_rating}.each do |key|
      hash[key] = send(key.to_sym)
    end
    hash
  end
end
