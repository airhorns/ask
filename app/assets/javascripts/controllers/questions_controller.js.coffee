class Ask.QuestionsController extends Batman.Controller
  index: (params) ->
    Ask.Survey.find params.surveyId, (err, survey) =>
      throw err if err
      @set 'survey', survey
      survey.get('questions').load (err, questions) =>
        throw err if err
        @set 'questions', questions

  show: (params) ->
    Ask.Question.find params.id, (err, question) =>
      throw err if err
      @set 'question', question

  #new: (params) ->
    #@set 'survey', Ask.Survey.find(params.surveyId, (err) -> throw err if err)
    #@set 'alert', new Ask.Alert(surveyId: params.surveyId)

  #create: ->
    #@get('alert').save (err) =>
      #if err
        #return if err instanceof Batman.ErrorsHash
        #throw err
      #Batman.redirect
        #controller: "alerts"
        #action: 'show'
        #surveyId: @get('survey.id')
