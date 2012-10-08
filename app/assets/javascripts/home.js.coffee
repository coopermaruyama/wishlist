# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
	window.cartpx = parseInt($('#gift-cart').css('right').split('p')[0]) #pixels of gift cart
	cart = $('#gift-cart')
	$('#items-tab').click ->
		right = cart.css('right')
		if right isnt '0px'
			cart.animate {right: 0}, 400
		else
			cart.animate {right: cartpx},400
	$('html').click ->
		if cart.css('right') is '0px' then $('#gift-cart').animate {right: cartpx}, 400
	$('#inner-gift-cart').click (e) ->
		e.stopPropagation()
