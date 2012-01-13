class Ask.Survey extends Ask.Model
  @storageKey: 'surveys'
  @persist Batman.RailsStorage

  @hasMany 'questions'
  @hasMany 'responses'
  @hasMany 'alerts'
    foreignKey: 'subject_id'
  @encode 'name', 'active', 'phone_number', 'responses_count', 'current_week_responses_count', 'previous_week_responses_count'

  @accessor 'firstRatedQuestion', -> @get('questions.indexedByUnique.rated?').get(true)
