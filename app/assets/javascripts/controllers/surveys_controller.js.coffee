class Ask.SurveysController extends Batman.Controller
  index: (params) ->
    console.log "at surveys"
    @set 'surveys', Ask.Survey.get('all')

  show: (params) ->
    Ask.Survey.find parseInt(params.id, 10), (err, survey) ->
      throw err if err
      @set 'survey', survey
