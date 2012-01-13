class Ask.Alert extends Ask.Model
  @storageKey: 'alerts'
  @persist Batman.RailsStorage
  @encode 'options', 'subject_type'
  @belongsTo 'survey',
    localKey: 'subject_id'

  @url: (options) ->
    surveyId = options.data.subject_id
    delete options.data.subject_id
    "/surveys/#{surveyId}/alerts"

  url: ->
    if @isNew()
      "/surveys/#{@get('surveyId')}/alerts"
    else
      "/alerts/#{@get('id')}"

  @accessor 'subject', -> Ask[@get('subject_type')].find(@get('subject_id'))
