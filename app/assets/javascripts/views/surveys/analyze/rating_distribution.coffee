#= require ../../d3_view

class Ask.RatingDistributionView extends Ask.D3View
  width: 100
  height: 100

  @accessor 'data', ->
    allData = @get('context').findKey('currentStats')[0]
    if allData? && allData.daily?
      allData.daily
    else
      []

  render: ->
    return unless node = @get('node')
    data = @get('data')
    d3.select(node).selectAll('*').remove()
    processed = {}
    counts = []
    for date, obj of data
      processed[date] = for k, v of obj
        counts.push v
        {rating: k, count: v}

    @maxCount = d3.max(counts) || 1
    @renderChart(daysData, date) for date, daysData of processed

    console.log 'rendered'
    @fire('ready')

  renderChart: (data, date) ->
    node = @get('node')
    chart = d3.select(node)
        .append('svg:svg')
          .attr('class', 'chart daily')
          .attr('width', @get('width'))
          .attr('height', @get('height'))

    w = @get('width')
    barWidth = w / 5
    h = @get('height')

    topPadding = 15
    bottomPadding = 30
    barsHeight = h - topPadding - bottomPadding
    x = d3.scale.linear()
      .domain([0, 5])
      .range([0, @get('width')])

    y = d3.scale.linear()
      .domain([0, @maxCount])
      .rangeRound([0, barsHeight])

    # Marks
    chart.selectAll("rect")
      .data(data)
    .enter().append("svg:rect")
      .attr("x", (d, i) -> x(i) - .5 )
      .attr("y", (d) -> barsHeight + topPadding - y(d.count) - .5 )
      .attr("width", barWidth)
      .attr("height", (d) -> return y(d.count) )

    # Count labels on top of the bars
    chart.selectAll("text.top_label")
      .data(data)
    .enter().append("svg:text")
      .attr("class", 'top_label')
      .text((d) -> d.count)
      .attr("x", (d, i) -> x(i) + barWidth/2 )
      .attr("y", (d) -> barsHeight + topPadding - y(d.count) - 8 )
      .attr("dx", 0)
      .attr("dy", ".35em")
      .attr("text-anchor", "middle")

    # Rating labels below the bars
    chart.selectAll("text.bottom_label")
      .data(data)
    .enter().append("svg:text")
      .attr("class", 'bottom_label')
      .text((d) -> d.rating)
      .attr("x", (d, i) -> x(i) + barWidth/2 )
      .attr("y", barsHeight + topPadding + 7)
      .attr("dx", 0)
      .attr("dy", ".35em")
      .attr("text-anchor", "middle")

    # Line across the x axis
    chart.append("svg:line")
      .attr("x1", 0)
      .attr("x2", w - 1)
      .attr("y1", barsHeight + topPadding - .5)
      .attr("y2", barsHeight + topPadding - .5)
      .attr("stroke", "#000")

    # Date
    format = d3.time.format("%Y-%m-%d")
    chart.append("svg:text")
      .attr('class', 'x_axis_label')
      .text("for #{format(@constructor.railsDateParser.parse(date))}")
      .attr("x", w / 2)
      .attr("y", h - 10)
      .attr("dx", 0)
      .attr("dy", ".35em")
      .attr("text-anchor", "middle")

