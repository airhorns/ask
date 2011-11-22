class Ask.Responder extends Ask.Model
  @storageKey: 'responders'
  @persist Batman.RailsStorage

  @encode 'phone_number'
  @hasMany 'responses'
