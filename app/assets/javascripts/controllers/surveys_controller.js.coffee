#= require_tree ../views/surveys/analyze

class Ask.SurveysController extends Batman.Controller
  index: (params) ->
    console.log "at surveys"
    @set 'surveys', Ask.Survey.get('all')

  show: (params) ->
    Ask.Survey.find params.id, (err, survey) =>
      throw err if err
      @set 'survey', survey

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
