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
    console.log "at surveys"
    @set 'surveys', Ask.Survey.get('all')

  show: (params) ->
    if params.id == String(@get('survey.id'))
      @set 'paginatedResponses.page', String(params.page)
      @_generatePages()
    else
      Ask.Survey.find params.id, (err, survey) =>
        throw err if err
        @set 'survey', survey
        @set 'paginatedResponses', new ResponsePaginator
          survey: survey
          totalCount: survey.get('responses_count')
          page: params.page

        @_generatePages()

  analyze: (params) ->
    Ask.Survey.find params.id, (err, survey) =>
      throw err if err
      @set 'survey', survey

  @accessor 'currentStats', ->
    ratedQuestions = @get('survey.questions')
    firstRatedQuestion = ratedQuestions.get('toArray.0')
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

