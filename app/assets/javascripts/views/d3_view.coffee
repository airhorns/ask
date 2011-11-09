#= require d3/d3
#= require d3/d3.layout
#= require d3/d3.chart

class Ask.D3View extends Batman.View
  width: 100
  height: 100

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
