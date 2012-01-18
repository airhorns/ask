class Ask.ResponsesController extends Batman.Controller

  class ResponsePaginator extends Batman.ModelPaginator
    model: Ask.Response
    limit: 25
    paramsForOffsetAndLimit: ->
      params = super
      params.survey_id = @get('survey.id')
      params

  index: (params) ->
    go = =>
      @set 'paginatedResponses.page', String(params.page || 1)
      @_generatePages()

    if params.id == String(@get('survey.id'))
      go()
    else
      Ask.Survey.find params.surveyId, (err, survey) =>
        @set 'survey', survey
        go()

  show: (params) ->
    Ask.Response.find params.id, (err, record) =>
      @set 'response', record

  _generatePages: ->
    total = @get('paginatedResponses.pageCount') + 1
    current = @get('paginatedResponses.page')
    min = Math.max(1, current - 5)
    max = Math.min(total, current + 5)
    @set 'responsePages', [min...max]
    @set 'nextPage', Math.min(current + 1, total)
    @set 'previousPage', Math.max(current - 1, 1)

  @accessor 'paginatedResponses', ->
    new ResponsePaginator
      survey: @get('survey')
      totalCount: @get('survey.responses_count')
      page: 1

