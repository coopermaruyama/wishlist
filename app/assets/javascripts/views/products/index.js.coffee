class Wishlist.Views.ProductsIndex extends Backbone.View
  events:#fire search even on key up
    "keyup input.input-search": "search"
    "mouseup .ui-slider-handle" : "search"  

  template: JST['products/index']#define template location
 
  initialize: ->
    @collection.on('reset', @render, this)#initalize search box on page load
    

  render: ->
    $(@el).html(@template(products: @collection))
    $('#slider-range').slider(#initialize slider!
      range: true
      min: 0
      max: 1000
      values: [0,500]
      slide: (event, ui) ->
        $('#amount').val("$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ])
      )

    $("#amount").val( '$' + $('#slider-range').slider('values', 0 ) + " - $" + $('#slider-range').slider('values', 1 ) )
    this

  search: (e) ->#fires on keyup
    letters = $('input.input-search').val()#grab letters from input
    if letters.match(/[^a-zA-Z0-9 ]/g) isnt null#find non alphanumerics
      letters = letters.replace(/[^a-zA-Z0-9 ]/g, '')##remove non alphanumerics
      $('.input-search').val(letters)#change input box's value to cleaned value
    if letters isnt '' 
      @renderList(@collection.search(letters))#search for models matching input value
      #above passes array of objects that are matched using search method on collection
    else $('#product-list').html('')

  renderList: (products) ->#passes in products COLLECTION
    $('#product-list').html('')
    
    products.each (product) ->#passes in product MODEL
      view = new Wishlist.Views.Product({model: product})
      low = $('#slider-range').slider('values', 0)
      high = $('#slider-range').slider('values', 1)
      if product.get('price') >= low and product.get('price') <= high
        $('#product-list').append(view.render().el)

    
class Wishlist.Views.Product extends Backbone.View#single item view
  template: JST['products/product']
  events: {}
  
    
  render: (data) ->#needs a MODEL passed to it!
    window.product = @model#make product variable available on global scope
    $(@el).html(@template)
    this




