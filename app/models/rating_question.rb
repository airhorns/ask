class RatingQuestion < Question
  def parse_rating(text)
    text
  end

  def rated?
    true
  end

  def answer!(response, text)
    answer = answer_for(response, text)
    answer.rate(parse_rating(text))
    answer.save!
  end
end
