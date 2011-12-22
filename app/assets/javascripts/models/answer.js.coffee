class Ask.Answer extends Ask.Model
  @storageKey: 'answers'
  @persist Batman.RailsStorage

  @encode 'text', 'numeric_rating', 'rated?'
  @belongsTo 'response'
  @belongsTo 'question'

  @url: (options) ->
    response_id = options.data.response_id
    delete options.data.response_id
    "/responses/#{response_id}/answers"
  url: -> "/responses/#{@get('response.id')}/answers/#{@get('id')}"

