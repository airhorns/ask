class Ask.Survey extends Batman.Model
  @storageKey: 'surveys'
  @persist Batman.RailsStorage

  @hasMany 'questions'
  @hasMany 'responses'
  @encode 'name', 'active', 'phone_number', 'response_count'
