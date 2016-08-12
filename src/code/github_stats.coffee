# provide last pushed at value for each repository
$(document).ready ->
  processVersion = (name, json)->
    # find the latest version
    version = json[0].name

    # display version on page
    $("##{name} .version").text("v#{version}")

  processRepos = (json)->
    # list of repo names on the page to process
    repo_names = [
      "RBD_Timer"
      "RBD_Button"
      "RBD_SerialManager"
      "RBD_Motor"
      "RBD_Light"
      "RBD_Servo"
    ]

    # group repo json by name
    json.shift()
    repos = {}
    $.each json, (i, repo)->
      repos[repo.name] = repo

    # iterate through all repos on the page
    $.each repo_names, (i, name)->
      # request the repo version
      $.ajax
        url: repos[name].tags_url
        success: (json)->
          processVersion(name, json)

      # convert the pushed_at value to timeago
      time = jQuery.timeago(repos[name].pushed_at)

      # display pushed_at value on page
      $("##{name} .updated").text("Updated #{time}")

  # call the github api for repo data
  $.ajax
    url:     "https://api.github.com/users/alextaujenis/repos"
    success: processRepos
