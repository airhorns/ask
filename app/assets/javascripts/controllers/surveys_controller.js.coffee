#= require_tree ../views/surveys/analyze
#= require models/response

class Ask.SurveysController extends Batman.Controller

  index: (params) ->
    @set 'surveys', Ask.Survey.get('all')

  show: (params) ->
    Ask.Survey.find params.id, (err, survey) =>
      throw err if err
      @set 'survey', survey

    Ask.Response.load {survey_id: params.id, limit: 20}, (err, responses) =>
      throw err if err
      @set 'recentResponses', responses

  analyze: (params) ->
    Ask.Survey.find params.id, (err, survey) =>
      throw err if err
      @set 'survey', survey

  edit: ->

  @accessor 'currentStats', ->
    firstRatedQuestion = @get('survey.firstRatedQuestion')
    if firstRatedQuestion
      firstRatedQuestion.get('stats')
    else
      {}
