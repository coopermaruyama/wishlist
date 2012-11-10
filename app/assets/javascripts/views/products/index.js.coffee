class Wishlist.Views.ProductsIndex extends Backbone.View
  events:#fire search even on key up
    "keyup input.input-search": "search"
    "mouseup .ui-slider-handle" : "search"
    "click .price-select" : "search"
  template: JST['products/index']#define template location
 
  initialize: ->
    @containerEl = @options.containerEl
    @render()
    @cookieCheck()
    @renderSaveButton()
    @collection.on("reset", @renderList, this)
    
  cookieCheck: ->
    ids = $.cookie('products')?.split(',') || []
    window.wishlist = new Wishlist.Collections.Products #initialize wishlist for window
    window.wishlist.fetch
      data: {ids: ids}
      add: true
      success: (products) =>
        products.each (product) =>
          view = new Wishlist.Views.listItem(model: product)

  render: ->
    $(@el).html(@template())
    $(@containerEl).html(@el)
    $('#slider-range').slider(#initialize slider!
      range: true
      min: 1
      max: 1000
      values: [0,500]
      slide: (event, ui) ->
        $('#amount').val("$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ])
      )
    $("#amount").val( '$' + $('#slider-range').slider('values', 0 ) + " - $" + $('#slider-range').slider('values', 1 ) )
    this

  search: (e) ->#fires on keyup
    letters = $('input.input-search').val()
    if letters.match(/[^a-zA-Z0-9 ]/g) isnt null#find non alphanumerics
      letters = letters.replace(/[^a-zA-Z0-9 ]/g, '')##remove non alphanumerics
      $('.input-search').val(letters)#change input box's value to cleaned value
    if letters isnt '' 
      $('#product-list').html('<img class="loading" src="assets/ajax_loader.gif">')
      window.loaded = 0
      clearTimeout(@searchTimeout)
      @searchTimeout = setTimeout =>
        @collection.fetch
          data: {q: letters, i: 1}
          success:
            @collection.fetch
              data: {q:letters, i:2}
              success:
                @collection.fetch
                  data: {q:letters, i:3}
      , 500
      
      #@renderList(@collection.search(letters))#search for models matching input value
      #above passes array of objects that are matched using search method on collection

  renderSaveButton: =>
    button = new Wishlist.Views.saveList
    button.render()

  renderList: (products) =>#passes in products COLLECTION
    if window.loaded == 0
      $('#product-list').html('')
      window.loaded = 1
    products.each (product) ->#passes in product MODEL
      view = new Wishlist.Views.Product({model: product})
      view.renderItem(product)

class Wishlist.Views.listItem extends Backbone.View
  template: JST['products/listitem']
  tagName: 'div'
  events:
    "click .delete" : "delete"
  initialize: ->
    @render()
    @bind("reset", @updateView)
  render: (data) ->
    $(@el).html(@template(model: @model)) if @model
    $('#items-tab-count').text(window.wishlist.length)
    $('#list-items').append(@el)
    @
  renderCart: (view) ->
    $('#items-tab-count').text(window.wishlist.length)
    $('#list-items').append(view.render().el)

  delete: (element) ->
    element.preventDefault()
    element.stopPropagation()
    window.wishlist.remove(@model)
    ids = $.cookie('products')?.split(',') || []
    if $.inArray("",ids) isnt -1 then ids.splice(ids.indexOf(''), 1)
    ids.splice(ids.indexOf(@model.get('id')),1)
    $.cookie('products', ids.join(','))
    @updateView(@model)
  updateView: ->
    @remove()
    $('#items-tab-count').text(window.wishlist.length)
  
class Wishlist.Views.saveList extends Backbone.View
  template: JST['products/saveList']
  tagName: 'span'
  el: '#saveListContainer'

  events:
    "click #save-button": "saveWishlist"

  render: (data) ->
    $(@el).html(@template)
    this

  redirect: ->
    console.log 'redirect'

  saveWishlist: (element) ->
    element.preventDefault()
    if $('#wishlist-type').val() isnt 'Select Wishlist Type'
      user = new Wishlist.Models.CurrentUser()
      fetch = user.fetch()
      fetch.complete ->
        userid = user.get('id')
        if userid is undefined
          console.log 'userid is undefined!'
          #TODO undefined reaction
          $('#login-modal').modal
            onOpen: (dialog) ->
              dialog.overlay.fadeIn 'fast', ->
                dialog.data.hide()
                dialog.container.fadeIn 'medium', ->
                  dialog.data.slideDown 'medium'
        
        else
          #lists = new Wishlist.Collections.Lists()
          list = new Wishlist.Models.List()
          listType = $('#wishlist-type').val()
          list.set({name: 'test', category: listType})
          list.url = '/user/' + userid + '/list'
          list.save()
          lineitems = new Wishlist.Collections.LineItems()
          lineitems.url = '/user/' + userid + '/list/line_items'
          window.li = 0
          window.wishlist.each (model) ->
            id = model.get('id')
            lineitems.create {product_id: id}, {success: lineitems.create_success, error: lineitems.create_error}
          #window.location.replace('/savelist/')
          

        #list.add(model: @model)
    else
      alert "Select a type of wishlist!"

class Wishlist.Views.FullProductView extends Backbone.View
  template: JST['products/fullview']
  el: '#full-view-container'
  tagName: 'div'
  className: 'full-view'

  events:
    "click #back-button" : "back"
    "click #add-button" : "add"

  initialize: ->
    
  render: ->
    $(@el).html(@template(model: @model))
    this

  back: ->
    $('#full-view-container').fadeOut(500)
    $('#product-list').fadeIn(500)
    $('#headline, #search-container').slideDown(500)

  add: (element) ->
    element.preventDefault()
    element.stopPropagation()
    #add a cookie
    window.addprod = @model
    ids = $.cookie('products')?.split(',') || []
    if $.inArray("",ids) isnt -1 then ids.splice(ids.indexOf(''), 1)
    ids.push(@model.get('id'))
    $.cookie('products', ids.join(','))
    window.wishlist.add(@model)
    #add model
    view = new Wishlist.Views.listItem(model: @model)
    @back()


class Wishlist.Views.Product extends Backbone.View#single item view
  template: JST['products/product']
  events: 
    "hover" : "overlay"
    "click .overlay" : "grow"

  tagName: 'div'
  className: 'product'
  
  overlay: (element) ->
    $(element.currentTarget).toggleClass('hover') unless $(element.currentTarget).attr('class').match(/full-view/i)# $(element.currentTarget) != $(this)

  renderItem: (product) =>
    low = parseInt($('#low-price').val())
    high = parseInt($('#high-price').val())
    if product.get('price') >= low and product.get('price') <= high
      searched = $('.input-search').val()
      if product.get('name').length < 35 then name =  product.get('name') else name = product.get('name').substr(0,35) + "..."
      regex = new RegExp("\\b" + searched + "\\b", "i")
      bold = name.replace(regex, '<span style="font-weight:bold;color:#F1592B;text-transform:capitalize;">' + searched + '</span>')
      $('#product-list').append(@render().el)
      $('#product-list').children().last().children('.product-title').html(bold)

  grow: (element) ->
      $('#full-view-container').html('<img class="loading" src="assets/ajax_loader.gif">')
      parent = $('#product-list')
      parent.fadeOut 300
      $('#headline,#search-container').slideUp()
      $('#full-view-container').fadeIn(900)
      model = new Wishlist.Models.Product
      model.id = @model.get('id')
      fetch = model.fetch()
      fetch.complete ->
        window.mprod = model
        model.attributes = model.attributes.table #investigate this
        view = new Wishlist.Views.FullProductView(model: model)
        view.render()

        


  render: (data) ->#needs a MODEL passed to it!
    window.product = @model#make product variable available on global scope
    $(@el).html(@template)
    this




