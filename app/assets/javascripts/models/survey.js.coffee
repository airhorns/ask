class Ask.Survey extends Batman.Model
  @storageKey: 'surveys'
  @persist Batman.RailsStorage

  @hasMany 'questions'
  @hasMany 'responses'
  @encode 'name', 'active', 'phone_number', 'response_count'

  @accessor 'stats'
    get: ->
      return @_stats if @_stats
      return if @_stats_request
      @_stats_request = new Batman.Request
        url: "/questions/#{@get('id')}/stats.json"
        success: (data) => @set 'stats', JSON.parse(data)
        error: (error) => throw error
      return
    set: (_, data) -> @_stats = data
