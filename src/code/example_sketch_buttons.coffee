# control the example sketch buttons with show/hide action
$(document).ready ->
  # memoize the drop-down menu & buttons
  menu = $(".example-sketch-buttons")
  buttons = menu.find("li")
  # set the button text
  $(".dropdown-toggle").html(buttons.first().text() + '&nbsp;<span class="caret"></span>')
  # show the menu
  menu.show()
  # capture the button click event
  buttons.on "click", (e)->
    # grab the button
    button = $(e.target)
    # make sure this button isn't selected
    if !button.hasClass("active")
      # remove active class from all buttons
      buttons.removeClass("active")
      # add active class to the clicked button
      button.addClass("active")
      selected_item = button.attr("data-target")
      #hide all example code and setup instructions
      $.when($('.code-item').fadeOut(50)).then ->
        # show the selected item
        $(".#{selected_item}").fadeIn(450)
        # change the name of the button
        $(".dropdown-toggle").html(button.text() + '&nbsp;<span class="caret"></span>')