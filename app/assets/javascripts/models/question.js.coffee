class Ask.Question extends Batman.Model
  @storageKey: 'questions'
  @persist Batman.RailsStorage

  @belongsTo 'survey'
  @encode 'text'

  @url: (options) ->
    delete options.survey_id
    "/surveys/#{options.survey_id}/questions"
  url: -> "/surveys/#{@get('survey.id')}/questions/#{@get('id')}"
