#= require_tree ../views/survey_segments/analyze
class Ask.SurveySegmentsController extends Batman.Controller
  index: (params) ->
    Ask.Survey.find params.surveyId, (err, survey) =>
      throw err if err
      @set 'survey', survey
      survey.get('segments').load (err, segments) =>
        throw err if err
        @set 'segments', segments

  show: (params) ->
    Ask.Survey.find params.surveyId, (err, survey) =>
      throw err if err
      @set 'survey', survey

    Ask.SurveySegment.find params.id, (err, segment) =>
      throw err if err
      @set 'segment', segment

  new: (params) ->
    @set 'survey', Ask.Survey.find(params.surveyId, (err) -> throw err if err)
    @set 'segment', new Ask.SurveySegment(surveyId: params.surveyId)

  create: ->
    @get('segment').save (err) =>
      if err
        return if err instanceof Batman.ErrorsHash
        throw err
      Batman.redirect
        controller: 'survey_segments'
        action: 'index'
        surveyId: @get('survey.id')

  destroy: (alert) ->
    segment.destroy (err) ->
      throw err if err

  @accessor 'formSubmitText', ->
    if @get('alert').isNew()
      "Create Segment"
    else
      "Update Segment"

