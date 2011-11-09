#= require ../../d3_view

data = [
  {rating: 1, count: 10},
  {rating: 2, count: 23},
  {rating: 3, count: 34},
  {rating: 4, count: 45},
  {rating: 5, count: 50}
]

class Ask.RatingDistributionView extends Ask.D3View
  width: 100
  height: 100

  @accessor 'data', -> @get('renderContext').findKey('currentStats')[0] || []
  render: ->
    chart = @get('chart')
    w = @get('width')
    barWidth = w / 5
    h = @get('height')
    #data = @get('data')

    topPadding = 15
    bottomPadding = 15
    barsHeight = h - topPadding - bottomPadding

    x = d3.scale.linear()
      .domain([0, 5])
      .range([0, @get('width')])

    y = d3.scale.linear()
      .domain([0, 50])
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

    console.log 'rendered'
    @fire('ready')

