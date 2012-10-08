class Wishlist.Collections.Products extends Backbone.Collection
  model: Wishlist.Models.Product

  url: '/api/products'


  search: (letters) ->
    if letters == "" then this

    pattern = new RegExp(letters,"gi")
    _ @filter (product) ->
      pattern.test(product.get('name'))

  priceFilter: (low, high) ->
    _(this.filter (data) ->
      price = data.get('price')
      price >= low and price <= high)

class Wishlist.Collections.Lists extends Backbone.Collection
  model: Wishlist.Models.List

class Wishlist.Collections.LineItems extends Backbone.Collection
  model: Wishlist.Models.LineItem

  create_success: (model, result, xhr) ->
    window.li++
    console.log li
    if window.li is window.wishlist.length then window.location.replace('/savelist/')

  create_error: (model, fail, xhr) ->
    window.li++
    console.log li
    if window.li is window.wishlist.length then window.location.replace('/savelist/')