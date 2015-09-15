$(document).ready ->
  # memoize
  top_link = $(".back-to-top")
  w = $(window)
  value = false

  top_link.hide()
  top_link.on "click", ->
    top_link.hide()
    value = $("#navbar-collapse").attr("aria-expanded")
    if value
      $("#toggle").click()

  # show and hide the back to top button
  w.scroll ->
    if w.scrollTop() > 100
      top_link.fadeIn(200)
    else
      top_link.fadeOut(200)