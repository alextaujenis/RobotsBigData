class Branding

  constructor: (opts)->
    # save the opts and window
    @el     = $(opts.el)
    @window = $(window)

    # Resize on page load
    @resize()

    # Resize on window resize
    @window.resize => @resize()

    # show the content
    $("#reveal").animate({opacity: 1});
    return

  resize: ->
    padding = (@window.height() / 2 - @el.height()) / 2
    shift_up = 60

    @el.css
      "padding-top":    padding - @el.offset().top - shift_up
      "padding-bottom": padding + shift_up
    return