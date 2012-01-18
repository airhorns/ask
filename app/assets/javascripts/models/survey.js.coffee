class Ask.Survey extends Ask.Model
  @storageKey: 'surveys'
  @persist Batman.RailsStorage

  @hasMany 'questions'
  @hasMany 'alerts'
    foreignKey: 'subject_id'

  @hasMany 'segments', {autoload: false, name: 'SurveySegment'}

  @encode 'name', 'active', 'current_week_responses_count', 'previous_week_responses_count'

  @accessor 'firstRatedQuestion', -> @get('questions.indexedByUnique.rated?').get(true)
  @accessor 'totalResponses', ->
    count = 0
    @get('segments').mapToProperty('responses_count').forEach (x) -> count += x
    count

