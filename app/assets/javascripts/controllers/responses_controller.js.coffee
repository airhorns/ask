class Ask.ResponsesController extends Batman.Controller
  show: (params) ->
    Ask.Response.find params.id, (err, record) =>
      @set 'response', record
