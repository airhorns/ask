class Ask.Question extends Batman.Model
  @storageKey: 'questions'
  @persist Batman.RailsStorage

  @belongsTo 'survey'
  @encode 'text', 'order', 'rated?'

  @url: (options) ->
    survey_id = options.survey_id
    delete options.survey_id
    "/surveys/#{survey_id}/questions"
  url: -> "/surveys/#{@get('survey.id')}/questions/#{@get('id')}"

  @accessor 'stats'
    get: ->
      return @_stats if @_stats
      return if @_stats_request
      @_stats_request = new Batman.Request
        url: "/questions/#{@get('id')}/stats.json"
        success: (data) => @set 'stats', data
        error: (error) => throw error
      return {}
    set: (_, data) -> @_stats = data
