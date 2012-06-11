#= require application
describe 'Products Collection', ->
	beforeEach ->
		collection = new Wishlist.Collections.Products
		collection.fetch()
		

describe 'Products Model', ->
	
	
	
	
describe 'Product Input View', ->
	beforeEach ->
		@products = new Wishlist.Collections.Products
		@products.fetch()
		window.product = new Wishlist.Views.ProductsIndex
		
	it "should know when the input field is empty", ->
		
	



describe 'Product List View', ->
	