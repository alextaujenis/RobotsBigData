$(document).ready(function(){var n,o,e;return n=$(".back-to-top"),e=$(window),o=!1,n.hide(),n.on("click",function(){return n.hide(),o=$("#navbar-collapse").attr("aria-expanded"),o?$("#toggle").click():void 0}),e.scroll(function(){return e.scrollTop()>100?n.fadeIn(200):n.fadeOut(200)})});