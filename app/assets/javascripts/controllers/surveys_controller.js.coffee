#= require_tree ../views/surveys/analyze
#= require models/response

class Ask.SurveysController extends Batman.Controller

  class ResponsePaginator extends Batman.ModelPaginator
    model: Ask.Response
    limit: 25
    paramsForOffsetAndLimit: ->
      params = super
      params.survey_id = @get('survey.id')
      params

  index: (params) ->
    @set 'surveys', Ask.Survey.get('all')

  show: (params) ->
    go = =>
      @set 'paginatedResponses.page', String(params.page || 1)
      @_generatePages()

    if params.id == String(@get('survey.id'))
      go()
    else
      Ask.Survey.find params.id, (err, survey) =>
        throw err if err
        @set 'survey', survey
        go()

  analyze: (params) ->
    Ask.Survey.find params.id, (err, survey) =>
      throw err if err
      @set 'survey', survey

  @accessor 'currentStats', ->
    firstRatedQuestion = @get('survey.firstRatedQuestion')
    if firstRatedQuestion
      firstRatedQuestion.get('stats')
    else
      {}

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

  @accessor 'alertsRouteOptions', ->
    {
      controller: 'alerts'
      action: 'index'
      surveyId: @get('survey.id')
    }
