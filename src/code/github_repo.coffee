class GithubRepo
  constructor: (opts = {})->
    @api = new GithubApi
      user: opts.user
      repo: opts.repo
    @

  render: ->
    @api.version (attributes)=>
      # convert the pushed_at value to timeago
      time = jQuery.timeago(attributes.published_at)

      # display published_at value on page
      $("##{@api.repo} .updated")
        .text("Updated #{time}")

      # display version on page
      $("##{@api.repo} .version")
        .text("v#{attributes.tag_name}")
      return
    return