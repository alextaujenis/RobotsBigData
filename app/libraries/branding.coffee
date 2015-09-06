class Branding

  constructor: (opts)->
    # save the opts and window
    @el     = $(opts.el)
    @window = $(window)

    # Resize on page load
    @resize()

    # Resize on window resize
    @window.resize => @resize()
    return

  resize: ->
    padding = (@window.height() - @el.height()) / 2

    @el.css
      "padding-top":    padding - @el.offset().top
      "padding-bottom": padding
    return