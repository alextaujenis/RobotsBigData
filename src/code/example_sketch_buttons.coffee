# control the example sketch buttons with show/hide action
$(document).ready ->
  $(window).navMenu()
  $(".nav-item").on "click", (e)->
    $(e.target).tooltip("hide")
    return
  return