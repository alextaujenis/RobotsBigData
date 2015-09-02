$(document).ready ->
  getting_started_link = $('a[href$="getting-started"]')
  getting_started_area = $('a[name="getting-started"]')
  examples_link = $('a[href$="examples"]')
  examples_area = $('a[name="hello-world"]')

  scrollToLink(getting_started_link, getting_started_area, 1000)
  scrollToLink(examples_link, examples_area, 2000)

scrollToLink = (link, area, timeout)->
  link.click (e)->
    e.preventDefault()
    $("html, body").animate
      scrollTop: area.offset().top
    , timeout
