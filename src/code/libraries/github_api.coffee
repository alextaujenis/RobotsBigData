class GithubApi
  constructor: (opts = {})->
    @user = opts.user
    @repo = opts.repo
    @version_url = "https://api.github.com/repos/#{@user}/#{@repo}/releases"
    @

  version: (callback)->
    xhr = new XMLHttpRequest()
    xhr.open('GET', @version_url, true)
    xhr.onreadystatechange = => @_processStateChange(xhr, callback)
    xhr.send()
    return


  # private

  _processStateChange: (xhr, callback)->
    if xhr.readyState == 4 && xhr.status == 200
      json = JSON.parse(xhr.responseText)
      json = @_sort(json)[0]
      callback(json)
    return

  _sort: (json)->
    json.sort (a, b)=>
      a = a.tag_name.split(".") # [0] = major, [1] = minor, [2] = patch, [3] = alpha/beta
      b = b.tag_name.split(".")

      a_major = @_parse(a[0])
      a_minor = @_parse(a[1])
      a_patch = @_parse(a[2])
      a_alpha = @_parse(a[3])

      b_major = @_parse(b[0])
      b_minor = @_parse(b[1])
      b_patch = @_parse(b[2])
      b_alpha = @_parse(b[3])

      # compare a release to a pre-release
      if a[2]? && b[2]?
        a_prerelease = a[2].match(/alpha/) # check for alpha words
        b_prerelease = b[2].match(/alpha/)
        a_prerelease = a_prerelease? && a_prerelease[0]? # convert to true/false
        b_prerelease = b_prerelease? && b_prerelease[0]?

        if !a_prerelease && b_prerelease
          return -1

      # check if higher patch level
      if a_major > b_major # major
        return -1

      if a_major == b_major && a_minor > b_minor # minor
        return -1

      if a_major == b_major && a_minor == b_minor && a_patch > b_patch # patch
        return -1

      if a_major == b_major && a_minor == b_minor && a_patch == b_patch && b_alpha == 0
        return 1

      if a_major == b_major && a_minor == b_minor && a_patch == b_patch && a_alpha > b_alpha # alpha
        return -1

      # else - must be a lower patch level
      return 1

  _parse: (number)->
    if number? && number != ""
      return parseInt(number)
    else
      return 0