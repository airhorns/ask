Batman.helpers.pluralize = (count, string) ->
    if string
      return string if count is 1
    else
      string = count

    len = string.length
    lastLetter = string.substr(len - 1)
    if lastLetter is 'y'
      return "#{string}s" if string.toLowerCase() == 'survey'
      "#{string.substr(0, len - 1)}ies"
    else if lastLetter is 's'
      string
    else
      "#{string}s"
