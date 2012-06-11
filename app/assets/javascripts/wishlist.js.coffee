window.Wishlist =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	init: -> 
		new Wishlist.Routers.Products()
		Backbone.history.start()

$(document).ready ->
	Wishlist.init()
	($ '#sign-in').click (e)->
		e.preventDefault()
		($ 'fieldset#signin_menu').toggle()
		($ '#signin-container').toggleClass('menu-open')

	($ 'fieldset#signin_menu').mouseup ->
		return false
		
	($ document).mouseup (e) ->
		if ($ e.target).parent('span#signin-container').length == 0
			($ 'span#signin-container').removeClass('menu-open')
			($ 'fieldset#signin_menu').hide()