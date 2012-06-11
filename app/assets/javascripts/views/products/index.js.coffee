class Wishlist.Views.ProductsIndex extends Backbone.View

  events:#fire search even on key up
    "keyup input.input-search": "search"  

  template: JST['products/index']#define template location
 
  initialize: ->
    @collection.on('reset', @render, this)#initalize search box on page load

  render: ->
    $(@el).html(@template(products: @collection))
    this

  search: (e) ->#fires on keyup
    letters = $('input.input-search').val()#grab letters from input
    if letters.match(/[^a-zA-Z0-9 ]/g) isnt null
      letters = letters.replace(/[^a-zA-Z0-9 ]/g, '')
      $('.input-search').val(letters)
    if letters isnt '' 
      @renderList(@collection.search(letters))#search for models matching input value
      #above passes array of objects that are matched using search method on collection
    else $('#product-list').html('')

  renderList: (products) ->#passes in products COLLECTION
    $('#product-list').html('')
    
    products.each (product) ->#passes in product MODEL
      view = new Wishlist.Views.Product({model: product})
      $('#product-list').append(view.render().el)

    
class Wishlist.Views.Product extends Backbone.View#single item view
  template: JST['products/product']
  events: {}
  
    
  render: (data) ->#needs a MODEL passed to it!
    window.product = @model#make product variable available on global scope
    $(@el).html(@template)
    this




