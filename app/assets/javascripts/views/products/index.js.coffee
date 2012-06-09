class Wishlist.Views.ProductsIndex extends Backbone.View

  template: JST['products/index']
 
  initialize: ->
    @collection.on('reset', @render, this)#callback

  render: ->
    $(@el).html(@template(products: @collection))
    this