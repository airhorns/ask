class StatsCalculator
  private
  def interpolate(query, *values)
    until values.size === 0
      query.sub!(/\?/, values.pop.to_s)
    end
    query
  end

  def execute(query, *values)
    ActiveRecord::Base.connection.execute(interpolate(query, *values)).to_a
  end

  def cast_to_numeric_on_date(data)
    data.map do |point|
      {x: point['x'].to_i, y: point['y'].to_f}
    end
  end
end

