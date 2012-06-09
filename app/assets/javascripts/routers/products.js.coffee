class Wishlist.Routers.Products extends Backbone.Router
	routes:
		'': 'index'
		'products/:id': 'show'
		
	initialize: ->
		@collection = new Wishlist.Collections.Products()
		@collection.fetch()
		
	index: ->
		view = new Wishlist.Views.ProductsIndex(collection: @collection)
		$('#container').html(view.render().el)
		
	show: (id) ->
		alert "Product #{id}"