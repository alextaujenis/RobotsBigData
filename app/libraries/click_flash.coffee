(($) ->
  $.fn.clickFlash = (opts)->
    class ClickFlash

      constructor: (w, opts)->
        @animateOnClick()
        @

      animateOnClick: ->
        $('a.click-flash').each (index, el)->
          href   = $(el).attr("href").replace("#",'')
          $(el).on "click", ->
            target = $("[name=#{href}]").parent().find("h4")
            time = 1250
            target
              .css({color: "#00a2ff", backgroundColor: "#EEE"})
              .stop(true)
              .animate({color: "#000", backgroundColor: "#FFF"}, time)

    new ClickFlash(@, opts)
    @

) jQuery