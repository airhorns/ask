#= require ../../d3_view
data = [
  {date: 0, rating: 3.7},
  {date: 1, rating: 4},
  {date: 2, rating: 4.5},
  {date: 3, rating: 5},
  {date: 4, rating: 4.9},
  {date: 5, rating: 4.8},
  {date: 6, rating: 4.9},
  {date: 7, rating: 4.8}
]

class Ask.RatingOverTimeView extends Ask.D3View
  width: 600
  height: 200

  @accessor 'data', -> @get('renderContext').findKey('currentStats')[0] || []
  render: ->
    node = @get('node')
    chart = @get('chart')

    #data = @get('data')
    #if !data || data.length == 0
      #@observe 'data', => @render()
      #return

    marginLeft = 15
    marginBottom = 20
    marginTop = 10

    w = @get('width')
    h = @get('height')

    x = d3.scale.linear()
      .domain([0, data.length-1])
      .range([marginLeft, w])

    y = d3.scale.linear()
      .domain([0, 5])
      .range([h - marginBottom, marginTop])

    # Line
    line = d3.svg.line()
      .x((d, i) -> x(i))
      .y((d) -> y(d.rating))

    chart.append("svg:path")
        .attr("d", line(data))

    # Lines for axis
    chart.append("svg:line")
      .attr("x1", x(0))
      .attr("y1", y(0) - 0.5)
      .attr("x2", w)
      .attr("y2", y(0) - 0.5)

    chart.append("svg:line")
      .attr("x1", marginLeft - 0.5)
      .attr("y1", marginTop)
      .attr("x2", marginLeft - 0.5)
      .attr("y2", h - marginBottom)

    # Axis tick labels
    chart.selectAll(".xLabel")
      .data(x.ticks(10))
      .enter().append("svg:text")
      .attr("class", "xLabel")
      .text(String)
      .attr("x", (d) -> x(d))
      .attr("y", 0)
      .attr("text-anchor", "middle")

    chart.selectAll(".yLabel")
      .data(y.ticks(5))
      .enter().append("svg:text")
      .attr("class", "yLabel")
      .text(String)
      .attr("x", 0)
      .attr("y", (d) -> y(d))
      .attr("text-anchor", "right")
      .attr("dy", 4)

    # Axis ticks
    chart.selectAll(".xTicks")
      .data(x.ticks(10))
      .enter().append("svg:line")
      .attr("class", "xTicks")
      .attr("x1", x)
      .attr("y1", y(0) + 2)
      .attr("x2", x)
      .attr("y2", y(0) - 2)

    chart.selectAll(".yTicks")
      .data(y.ticks(5))
      .enter().append("svg:line")
      .attr("class", "yTicks")
      .attr("y1", y)
      .attr("x1", x(0) - 2.5)
      .attr("y2", y)
      .attr("x2", x(0) + 2.5)

    @fire('ready')
