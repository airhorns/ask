class Ask.Responder extends Batman.Model
  @storageKey: 'responders'
  @persist Batman.RailsStorage

  @encode 'phone_number'
  @hasMany 'responses'
