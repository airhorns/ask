class Ask.Response extends Ask.Model
  @storageKey: 'responses'
  @persist Batman.RailsStorage

  @belongsTo 'segment', {name: 'SurveySegment'}
  @belongsTo 'responder'
  @hasMany 'answers', {autoload: false}

  @url: (options) ->
    survey_id = options.data.survey_id
    delete options.data.survey_id
    "/surveys/#{survey_id}/responses"
  url: -> "/responses/#{@get('id')}"

  @encode 'complete'
