class Ask.Answer extends Batman.Model
  @storageKey: 'answers'
  @persist Batman.RailsStorage

  @encode 'text'
  @belongsTo 'response'
  @belongsTo 'question'

  @url: (options) ->
    response_id = options.response_id
    delete options.response_id
    "/responses/#{response_id}/answers"
  url: -> "/responses/#{@get('response.id')}/answers/#{@get('id')}"

