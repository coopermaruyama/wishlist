class Wishlist.Collections.Products extends Backbone.Collection

  model: Wishlist.Models.Product
  url: '/api/products'