# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
not ((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  unless d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = "//platform.twitter.com/widgets.js"
    fjs.parentNode.insertBefore js, fjs
) document, "script", "twitter-wjs"


window.valentines = =>
	$('body').addClass('vday')
	$('img.logo').attr('src', '/assets/vday-logo.png')
	$('header').css('background-image','url("/assets/vday-header.png")')