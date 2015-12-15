(($) ->
  $.fn.navMenu = (opts)->
    class NavMenu
      constructor: (w, opts)->
        # memoize the window
        @window = w
        # find the nav menu
        @menu = $(".nav-menu")
        # find the menu nav items
        @nav_items = @menu.find(".nav-item")
        # find the nav content items
        @nav_content = $(".nav-content")
        # configure the plugin
        @setup()
        # return a reference to self
        @

      setup: ->
        # show the nav menu
        @menu.show()
        # set the first nav menu item as active
        @nav_items.first().addClass("active")
        # add click handler to the nav items
        @nav_items.on('click', (e)=> @clickEvent(e))
        return

      clickEvent: (e)->
        # memoize the clicked element
        button = $(e.target)
        # remove the active class from all nav items
        @nav_items.removeClass("active")
        # add the active class the the clicked nav item
        button.addClass("active")
        # hide all content
        @nav_content.hide()
        # show the selected content
        $(".#{button.attr("data-target")}").show()
        return

    new NavMenu(@, opts)
) jQuery