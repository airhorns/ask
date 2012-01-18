class Ask.Survey extends Ask.Model
  @storageKey: 'surveys'
  @persist Batman.RailsStorage

  @hasMany 'questions'
  @hasMany 'alerts'
    foreignKey: 'subject_id'

  @hasMany 'segments', {autoload: false, name: 'SurveySegment'}

  @encode 'name', 'active', 'stats'

  @accessor 'firstRatedQuestion', -> @get('questions.indexedByUnique.rated?').get(true)
