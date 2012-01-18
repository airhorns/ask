class Ask.RatingGraphView extends Batman.View
  @accessor 'data', ->
    @get('context').get(@get('dataKeyPath')) || [{x: 0, y:0}]

  @accessor 'dataKeyPath', ->
    @get("node").getAttribute('data-data')

  @accessor 'width', ->
    nodeWidth = @get('node').getAttribute('data-width')
    if nodeWidth
      parseInt(nodeWidth)
    else
      @defaultWidth

  @accessor 'height', ->
    nodeHeight = @get('node').getAttribute('data-height')
    if nodeHeight
      parseInt(nodeHeight)
    else
      @defaultHeight

  @accessor 'legendEnabled', ->
    nodeValue = @get('node').getAttribute('data-legend')
    if nodeValue
      nodeValue == true
    else
      @defaultLegendEnabled

  defaultWidth: 620
  defaultHeight: 300
  defaultLegendEnabled: true

  render: ->
    super
    chartNode = $("<div>").appendTo(@node)[0]
    seriesA = @get('data')
    @graph = new Rickshaw.Graph
      element: chartNode
      width: @get('width')
      height: @get('height')
      renderer: "line"
      series: [
        color: "#c05020"
        data: seriesA
        name: "Average Rating"
      ]

    @graph.render()

    hoverDetail = new Rickshaw.Graph.HoverDetail
      graph: @graph

    xAxis = new Rickshaw.Graph.Axis.Time
      graph: @graph

    xAxis.render()

    yAxis = new Rickshaw.Graph.Axis.Y
      graph: @graph
      tickFormat: Rickshaw.Fixtures.Number.formatKMBT

    yAxis.render()

    if @get('legendEnabled')
      legendNode = $("<div>").appendTo(@node)[0]
      legend = new Rickshaw.Graph.Legend
        graph: @graph
        element: legendNode

      shelving = new Rickshaw.Graph.Behavior.Series.Toggle
        graph: @graph
        legend: legend

    @observe 'data', (data) =>
      seriesA.pop() until seriesA.length == 0
      seriesA.push(item) for item in data
      @graph.update()
