window.Ask = class Ask extends Batman.App

  Batman.View::prefix = 'assets/views'

  @resources 'survey'
  @route 'surveys/:id/analyze', "surveys#analyze", {resource: 'surveys', action: 'analyze'}
  @root 'dashboard#index'

  @on 'run', ->
    console?.log "Running ...."

  @on 'ready', ->
    console?.log "Ask ready for use."

  @flash: Batman()
  @flash.accessor
    get: (key) -> @[key]
    set: (key, value) ->
      @[key] = value
      if value isnt ''
        setTimeout =>
          @set(key, '')
        , 2000
      value

  @flashSuccess: (message) -> @set 'flash.success', message
  @flashError: (message) ->  @set 'flash.error', message
