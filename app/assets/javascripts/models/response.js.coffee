class Ask.Response extends Ask.Model
  @storageKey: 'responses'
  @persist Batman.RailsStorage

  @belongsTo 'survey'
  @belongsTo 'responder'
  @hasMany 'answers', {autoload: false}

  @url: (options) ->
    survey_id = options.survey_id
    delete options.survey_id
    "/surveys/#{survey_id}/responses"
  url: -> "/responses/#{@get('id')}"

  @encode 'complete'
