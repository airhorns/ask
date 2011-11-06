class Ask.Question extends Batman.Model
  @storageKey: 'questions'
  @persist Batman.RailsStorage

  @belongsTo 'survey'
  @encode 'text', 'order'

  @url: (options) ->
    survey_id = options.survey_id
    delete options.survey_id
    "/surveys/#{survey_id}/questions"
  url: -> "/surveys/#{@get('survey.id')}/questions/#{@get('id')}"
