$(document).ready ->
  # Scroll down to learn more on index page
  hardware_link = $('a[href$="hardware-overview"]')
  hardware_area = $('a[name="hardware-overview"]')

  scrollToLink(hardware_link, hardware_area, 1000)

  # Resize the branding boxes to center the content
  new Branding
    el: ".branding"

scrollToLink = (link, area, timeout)->
  link.click (e)->
    e.preventDefault()
    $("html, body").animate
      scrollTop: area.offset().top - 70 # topbar offset
    , timeout