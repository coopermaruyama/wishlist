class Wishlist.Routers.Products extends Backbone.Router
	routes:
		'': 'index'
		'products/:id': 'show'
		
	initialize: ->
		@collection = new Wishlist.Collections.Products()
		
	index: ->
		new Wishlist.Views.ProductsIndex(collection: @collection, containerEl: $('#search-container'))
		
	show: (id) ->
		alert "Product #{id}"

	
