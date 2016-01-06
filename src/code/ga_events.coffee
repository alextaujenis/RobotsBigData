$(document).ready ->
  $('.ga-events').each (index, el)->
    $(el).click ->
      ga('send', {
        hitType:       'event'
        eventCategory: 'Software'
        eventAction:   'download'
        eventLabel:    $(el).attr("data-name")
      })