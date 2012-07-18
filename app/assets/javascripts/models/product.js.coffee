class Wishlist.Models.Product extends Backbone.Model

class Wishlist.Models.List extends Backbone.Model
	
class Wishlist.Models.LineItem extends Backbone.Model

class Wishlist.Models.CurrentUser extends Backbone.Model
	url: '/currentuser'
	idAttribute: '_id'

	initalize: ->
		@fetch()
		console.log @get('id')