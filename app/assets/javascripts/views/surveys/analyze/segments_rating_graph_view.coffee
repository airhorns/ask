class Ask.SegmentsRatingGraphView extends Batman.View
  @accessor 'survey', -> @get('context').get(@get('surveyKeyPath'))

  @accessor 'surveyKeyPath', ->
    @get("node").getAttribute('data-survey')

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

  defaultWidth: 760
  defaultHeight: 300

  render: ->
    legendNode = $('<div id="survey_segments_legend">').appendTo(@node)[0]
    chartNode = $("<div>").appendTo(@node)[0]
    palette = new Rickshaw.Color.Palette(scheme: 'classic9')

    @observeAndFire 'survey.segments', (segments) =>
      return unless segments && segments.length > 0
      datas = []
      segments.forEach ->
        datas.push [{x: 1, y: 1}]

      series = []
      segments.forEach (segment, i) ->
        palette.color()
        series.push {
          color: palette.color()
          name: segment.get('name')
          data: datas[i]
        }

      @graph = new Rickshaw.Graph
        element: chartNode
        width: @get('width')
        height: @get('height')
        renderer: "line"
        series: series

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

      legend = new Rickshaw.Graph.Legend
        graph: @graph
        element: legendNode

      shelving = new Rickshaw.Graph.Behavior.Series.Toggle
        graph: @graph
        legend: legend

      segments.forEach (segment, i) =>
        segment.observeAndFire 'stats', (stats) =>
          return unless stats.daily_average_rating
          data = series[i].data
          data.pop() until data.length == 0
          data.push(item) for item in stats.daily_average_rating
          if series.every((s) -> s.data.length == stats.daily_average_rating.length)
            @graph.update()

    super
