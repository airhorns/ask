class SurveySegmentStats < StatsCalculator
  AVERAGE_DAILY_RATING_QUERY = <<-eos
    SELECT
        EXTRACT(EPOCH FROM date_trunc('day', "answers".created_at)) as x,
        AVG(cast("answer_meta_data".value as int)) as y
    FROM "answers"
      INNER JOIN "responses" ON "responses"."id" = "answers"."response_id"
      INNER JOIN "answer_meta_data" ON "answer_meta_data"."answer_id" = "answers"."id" AND "answer_meta_data"."key" = 'rating'
    WHERE "responses"."survey_segment_id" = ?
    GROUP BY date_trunc('day', "answers".created_at)
    ORDER BY x
  eos

  DAILY_RESPONSES_QUERY = <<-eos
    SELECT
      EXTRACT(EPOCH FROM date_trunc('day', responses.created_at)) as x,
      COUNT(*) as y
    FROM responses
    WHERE responses.survey_segment_id = ?
    GROUP BY date_trunc('day', responses.created_at)
    ORDER BY x
  eos

  attr_reader :segment
  def initialize(segment)
    @segment = segment
  end

  def daily_average_rating
    cast_to_numeric_on_date(execute(AVERAGE_DAILY_RATING_QUERY, @segment.id))
  end

  def daily_response_count
    cast_to_numeric_on_date(execute(DAILY_RESPONSES_QUERY, @segment.id))
  end

  def as_json(options = {})
    daily_ratings = daily_average_rating
    daily_response_counts = daily_response_count
    {
      'daily_average_rating' => daily_ratings,
      'daily_response_count' => daily_response_counts,
      'today_average_rating' => daily_ratings[daily_ratings.size - 1][:y],
      'yesterday_average_rating' => daily_ratings[daily_ratings.size - 2][:y],
      'today_response_count' => daily_response_counts[daily_response_counts.size - 1][:y],
      'yesterday_response_count' => daily_response_counts[daily_response_counts.size - 2][:y]
    }
  end
end
