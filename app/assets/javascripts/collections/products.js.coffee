class Wishlist.Collections.Products extends Backbone.Collection

	model: Wishlist.Models.Product
	url: '/api/products'

	search: (letters) ->
		if letters == "" then this
		
		pattern = new RegExp(letters,"gi")
		_(this.filter((data) ->
			pattern.test(data.get("name"))))
	
	priceFilter: (low, high) ->
		_(this.filter (data) ->
			price = data.get('price')
			price >= low and price <= high)
