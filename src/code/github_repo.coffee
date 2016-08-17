class GithubRepo
  constructor: (opts = {})->
    @api = new GithubApi
      user: opts.user
      repo: opts.repo
    @

  render: ->
    @api.version (attributes)=>
      # display version on page
      $("##{@api.repo} .version").text("v#{attributes.name}")
      return
    return