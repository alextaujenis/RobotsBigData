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
    repo = new GithubRepo
      user: user
      repo: repo

    repo.render()
    return
  return