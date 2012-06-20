#=require application
describe "Products Collection", ->
	
	it "should filter a specific price", ->
		products = new Wishlist.Collections.Products [{name: 'product1', price: 15.99}, {name: 'product2', price: 21.99}, {name: 'product3', price: 21.99}, {name: 'product4', price: 1.99}]
		match = products.where({price: 21.99})
		expect(match.length).toBe(2)	
		
	it "should filter a range of prices and return an array of models", ->
		products = new Wishlist.Collections.Products
		products.add({name: 'product1', price: 15.99})
		products.add({name: 'product2', price: 21.99})
		products.add({name: 'product3', price: 21.99})
		products.add({name: 'product4', price: 1.99})
		expect(products.priceFilter(16,25).size()).toBe(2)