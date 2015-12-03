$(document).ready ->
  $(".download-button").hide() if /(iPad|iPhone|iPod)/g.test(navigator.userAgent)

  $('.download-button').click ->
    $('#modal').modal()

  $('.close-modal').click ->
    $('#modal').modal("hide")