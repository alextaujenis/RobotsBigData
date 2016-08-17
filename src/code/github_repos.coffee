# render each repo version name and published_at timestamp (timeago)
$(document).ready ->
  user  = "alextaujenis"
  repos = [
    "RBD_Timer"
    "RBD_Button"
    "RBD_SerialManager"
    "RBD_Motor"
    "RBD_Light"
    "RBD_Servo"
  ]

  $.each repos, (i, repo)->
    api = new GithubApi
      user: user
      repo: repo

    api.version (attributes)->
      # convert the pushed_at value to timeago
      time = jQuery.timeago(attributes.published_at)

      # display version on page
      $("##{repo} .version").text("v#{attributes.name}")

      # display published_at value on page
      $("##{repo} .updated").text("Updated #{time}")
      return
    return