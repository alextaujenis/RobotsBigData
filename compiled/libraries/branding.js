var Branding;Branding=function(){function i(i){this.el=$(i.el),this.window=$(window),this.resize(),this.window.resize(function(i){return function(){return i.resize()}}(this))}return i.prototype.resize=function(){var i,t;i=(this.window.height()-this.el.height())/2,t=60,this.el.css({"padding-top":i-this.el.offset().top-t,"padding-bottom":i+t})},i}();