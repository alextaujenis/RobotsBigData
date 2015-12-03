$(document).ready ->
  $('.download-button').click ->
    $('#modal').modal()

  $('.close-modal').click ->
    $('#modal').modal("hide")