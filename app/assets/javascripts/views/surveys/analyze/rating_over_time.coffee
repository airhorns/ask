#= require ../../d3_view

class Ask.RatingOverTimeView extends Ask.D3View
  width: 600
  height: 200

  @accessor 'data', ->
    allData = @get('renderContext').findKey('currentStats')[0]
    if allData? && allData.monthly?
      ({date: @constructor.railsDateParser.parse(k), rating: v} for k, v of allData.monthly)
    else
      []

  render: ->
    node = @get('node')
    chart = @get('chart').attr('class', 'chart monthly')
    data = @get('data')
    if !data || data.length == 0
      @observe 'data', => @render()
      return

    marginLeft = 25
    marginBottom = 35
    marginTop = 10

    w = @get('width')
    h = @get('height')

    minDate = d3.min(data.map (d) -> d.date)
    maxDate = d3.max(data.map (d) -> d.date)

    x = d3.time.scale.utc()
      .domain([minDate, maxDate])
      .range([marginLeft, w])

    xTicks = x.ticks(d3.time.days, 4)

    y = d3.scale.linear()
      .domain([0, 5])
      .range([h - marginBottom, marginTop])

    # Line
    line = d3.svg.line()
      .x((d) -> x(d.date))
      .y((d) -> y(d.rating))

    chart.append("svg:path")
        .attr("d", line(data))

    # Lines for axis
    chart.append("svg:line")
      .attr("x1", marginLeft)
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
      .data(xTicks)
      .enter().append("svg:text")
      .attr("class", "xLabel")
      .text(d3.time.format("%b %e"))
      .attr("x", x)
      .attr("y", (h - marginBottom + 15))
      .attr("text-anchor", "middle")

    chart.selectAll(".yLabel")
      .data(y.ticks(5))
      .enter().append("svg:text")
      .attr("class", "yLabel")
      .text(String)
      .attr("x", marginLeft - 10)
      .attr("y", (d) -> y(d))
      .attr("text-anchor", "right")
      .attr("dy", 4)

    # Axis ticks
    chart.selectAll(".xTicks")
      .data(xTicks)
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
      .attr("y1", (d) -> y(d) - 0.5)
      .attr("x1", marginLeft - 2.5)
      .attr("y2", (d) -> y(d) - 0.5)
      .attr("x2", marginLeft + 2.5)

    # Axis labels
    chart.append("svg:text")
      .attr('class', 'x_axis_label')
      .text("Date")
      .attr("x", w / 2)
      .attr("y", h - 10)
      .attr("dx", 0)
      .attr("dy", ".35em")
      .attr("text-anchor", "middle")

    label_x = marginLeft - 20
    label_y = h / 2
    chart.append("svg:text")
      .attr('class', 'x_axis_label')
      .text("Average Rating")
      .attr("x", label_x)
      .attr("y", label_y)
      .attr("dx", 0)
      .attr("dy", ".35em")
      .attr("text-anchor", "middle")
      .attr("transform", "rotate(-90 #{label_x},#{label_y})")

    @fire('ready')
