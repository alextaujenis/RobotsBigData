$(document).ready(function(){var t,a;return a=$(".example-sketch-buttons"),t=a.find("li"),$(".dropdown-toggle").html(t.first().text()+'&nbsp;<span class="caret"></span>'),a.show(),t.on("click",function(a){var e,n;return e=$(a.target),e.hasClass("active")?void 0:(t.removeClass("active"),e.addClass("active"),n=e.attr("data-target"),$.when($(".code-item").fadeOut(50)).then(function(){return $("."+n).fadeIn(450),$(".dropdown-toggle").html(e.text()+'&nbsp;<span class="caret"></span>')}))})});