class Ask.SurveySegment extends Ask.Model
  @storageKey: 'survey_segments'
  @persist Batman.RailsStorage

  @encode 'name', 'phone_number', 'responses_count'
  @belongsTo 'survey'
  @hasMany 'responses'

  @url: (options) ->
    surveyId = options.data.survey_id
    delete options.data.survey_id
    "/surveys/#{surveyId}/survey_segments"


  url: ->
    if @isNew()
      "/surveys/#{@get('surveyId')}/survey_segments"
    else
      "/survey_segments/#{@get('id')}"

  @accessor 'stats'
    get: ->
      return @_stats if @_stats
      return if @_stats_request
      @_stats_request = new Batman.Request
        url: "/survey_segments/#{@get('id')}/stats.json"
        success: (data) => @set 'stats', data
        error: (error) => throw error
      return {}
    set: (_, data) -> @_stats = data

