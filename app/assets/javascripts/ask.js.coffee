window.Ask = class Ask extends Batman.App

  Batman.ViewStore.prefix = 'assets/views'

  @resources 'surveys', ->
    @member 'analyze'
    @resources 'alerts'
    @resources 'questions'
    @resources 'surveySegments', ->
      @resources 'responses'

  @resources 'responses'

  @root 'surveys#index'

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
