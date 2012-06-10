class Wishlist.Views.ProductsIndex extends Backbone.View

  events:#fire search even on key up
    "keyup input.input-search": "search"  

  template: JST['products/index']#define template location
 
  initialize: ->
    @collection.on('reset', @render, this)#callback

  render: ->
    $(@el).html(@template(products: @collection))
    this

  search: (e) ->#fires on keyup
    letters = $('input.input-search').val()#grab letters from input
    @renderList(@collection.search(letters))#search for models matching input value
    #above passes array of objects that are matched using search method on collection

  renderList: (products) ->#passes in products COLLECTION
    $('#product-list').html('')
    
    products.each (product) ->#passes in product MODEL
      view = new Wishlist.Views.Product({model: product})
      $('#product-list').append(view.render().el)
    
class Wishlist.Views.Product extends Backbone.View
  template: JST['products/product']
  events: {}
  
    
  render: (data) ->#needs o MODEL passed 
    window.product = @model
    $(@el).html(@template)
    this




