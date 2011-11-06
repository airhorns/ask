class Ask.Response extends Batman.Model
  @storageKey: 'responses'
  @persist Batman.RailsStorage

  @belongsTo 'survey'
  @belongsTo 'responder'
  @hasMany 'answers'

  @url: (options) ->
    survey_id = options.survey_id
    delete options.survey_id
    "/surveys/#{survey_id}/responses"
  url: -> "/surveys/#{@get('survey.id')}/responses/#{@get('id')}"
