# show and hide the 'back to top' button on scroll across the entire site
$(document).ready ->
  top_link = $(".back-to-top")
  w        = $(window)
  value    = false

  # initially hide the button
  top_link.hide()

  # hide the twitter bootstrap drop-down when the button is clicked
  # this only applies for mobile
  top_link.on "click", ->
    top_link.hide()
    value = $("#navbar-collapse").attr("aria-expanded")
    if value
      $("#toggle").click()

  # show and hide the 'back to top' button
  w.scroll ->
    if w.scrollTop() > 100
      top_link.stop().fadeIn(200)
    else
      top_link.stop().fadeOut(200)