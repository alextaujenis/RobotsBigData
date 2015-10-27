# for each link with the class .click-flash
# this will find the page anchor and then the nearest h4 element
# then run an animation to quickly highlight the h4 element
(($) ->
  $.fn.clickFlash = (opts)->
    class ClickFlash

      constructor: (w, opts)->
        @animateOnClick()
        @

      animateOnClick: ->
        $('a.click-flash').each (index, el)->
          href = $(el).attr("href").replace("#",'')
          $(el).on "click", ->
            target = $("##{href}").parent()
            time = 1250
            target
              .css({color: "#00a2ff", backgroundColor: "#EEE"})
              .stop(true)
              .animate({color: "#000", backgroundColor: "#FFF"}, time)

    new ClickFlash(@, opts)
    @

) jQuery