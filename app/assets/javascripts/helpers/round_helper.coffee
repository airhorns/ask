Batman.Filters.round = (val, digits) ->
  return undefined if typeof val is 'undefined'
  multiplier = Math.pow(10, digits)
  val = val * multiplier
  val = Math.round(val)
  val = val / multiplier
  val.toFixed(digits)
