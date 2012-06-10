window.Wishlist =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    new Wishlist.Routers.Products()
    Backbone.history.start()

$(document).ready ->
  Wishlist.init()
