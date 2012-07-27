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
	# ($ '#sign-in').click (e)->#toggle signin form when signin is clicked
# 	e.preventDefault()
	# 	($ 'fieldset#signin_menu').toggle()
	# 	($ '#signin-container').toggleClass('menu-open')

	($ 'fieldset#signin_menu').mouseup ->#avoid closing when clicking the signin box itself
		return false
		
	($ document).mouseup (e) ->#close if click outside of signin box
		if ($ e.target).parent('span#signin-container').length == 0
			($ 'span#signin-container').removeClass('menu-open')
			($ 'fieldset#signin_menu').hide()
			
	$('input.input-search').change ->
		val = $('.input-search').val()
		if val.match(/[^a-zA-Z0-9 ]/g) isnt null
			new_val = val.replace(/[^a-zA-Z0-9 ]/g, '')
			$('.input-search').val(new_val)

	window.signupUser = ->
		$('#lightBox').show()