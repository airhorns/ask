class Ask.AlertsController extends Batman.Controller

  index: (params) ->
    Ask.Survey.find params.surveyId, (err, survey) =>
      throw err if err
      @set 'survey', survey
      survey.get('alerts').load (err, alerts) =>
        throw err if err
        @set 'alerts', alerts

  show: (params) ->
    Ask.Alert.find params.id, (err, alert) =>
      throw err if err
      @set 'alert', alert

  new: (params) ->
    @set 'survey', Ask.Survey.find(params.surveyId, (err) -> throw err if err)
    @set 'alert', new Ask.Alert(surveyId: params.surveyId)

  create: ->
    @get('alert').save (err) =>
      if err
        return if err instanceof Batman.ErrorsHash
        throw err
      Batman.redirect
        controller: "alerts"
        action: 'show'
        surveyId: @get('survey.id')

  destroy: (alert) ->
    alert.destroy (err) ->
      throw err if err

  @accessor 'newAlertOptions', ->
    {
      controller: 'alerts'
      action: 'new'
      surveyId: @get('survey.id')
    }

  @accessor 'formSubmitText', ->
    if @get('alert').isNew()
      "Create Alert"
    else
      "Update Alert"
