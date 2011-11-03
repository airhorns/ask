class Ask.SurveysController extends Batman.Controller
  index: (params) ->
    @set 'surveys', Ask.Survey.get('all')
