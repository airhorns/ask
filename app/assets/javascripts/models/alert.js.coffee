class Ask.Alert extends Ask.Model
  @storageKey: 'alerts'
  @persist Batman.RailsStorage

  @url: (options) ->
    survey_id = options.data.survey_id
    delete options.data.survey_id
    "/surveys/#{survey_id}/alerts"

  url: -> "/alerts/#{get('id')}"

  @accessor 'subject', -> Ask[@get('subject_type')].find(@get('subject_id'))
