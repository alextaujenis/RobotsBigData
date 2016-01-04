# http://alexgorbatchev.com/SyntaxHighlighter/manual/installation.html
$(document).ready ->
  SyntaxHighlighter.defaults.toolbar = false
  SyntaxHighlighter.defaults['quick-code'] = false
  SyntaxHighlighter.all()

  $(window).clickFlash()