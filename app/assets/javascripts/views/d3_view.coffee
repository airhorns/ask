#= require d3/d3
#= require d3/d3.layout
#= require d3/d3.chart
#= require d3/d3.time

class Ask.D3View extends Batman.View
  width: 100
  height: 100
  @railsDateParser = d3.time.format("%Y-%m-%d %H:%M:%S UTC")
  @accessor 'renderContext', -> Batman.RenderContext.start(@get('contexts')...)
  @accessor 'chart'
    get: ->
      return unless node = @get('node')
      d3.select(node)
        .append('svg:svg')
          .attr('class', 'chart')
          .attr('width', @get('width'))
          .attr('height', @get('height'))
    final: true
