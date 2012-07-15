class Wishlist.Views.ProductsIndex extends Backbone.View
  events:#fire search even on key up
    "keyup input.input-search": "search"
    "mouseup .ui-slider-handle" : "search"

  template: JST['products/index']#define template location
 
  initialize: ->
    @collection.on('reset', @render, this)#initalize search box on page load
    #look for products in cookies
    @collection.on('reset', @cookieCheck, this)
      #listView = new Wishlist.Views.listItemView
    @collection.on('reset', @renderSaveButton, this)

  cookieCheck: ->
    key = "products="
    for c in document.cookie.split(';')
      c.substring(1, c.length) while c.charAt(0) is ' '
      products = c.substring(key.length, c.length) if c.indexOf(key) == 0
    if products
      cd = products.split(',')
    window.wishlist = new Wishlist.Collections.Products #initialize wishlist for window
    if cd
      for i in cd when i isnt 'undefined' or ''
        product = @collection.get(i)
        view = new Wishlist.Views.listItem({model: product})
        ## share this collection with other views via window list! ##
        window.wishlist.add(product)
        ## append to view ##
        $('#list-items').append(view.render().el)
        listheight = ($ '.wishlist').height()
        rowheight = ($ '.row').height()
        newheight = rowheight + listheight
        ($ '.wishlist').height(newheight)

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

  renderSaveButton: ->
    button = new Wishlist.Views.saveList
    button.render()

  renderList: (products) ->#passes in products COLLECTION
    $('#product-list').html('')
    
    products.each (product) ->#passes in product MODEL
      view = new Wishlist.Views.Product({model: product})
      low = $('#slider-range').slider('values', 0)
      high = $('#slider-range').slider('values', 1)
      if product.get('price') >= low and product.get('price') <= high
        searched = $('.input-search').val()
        name = product.get('name')
        bold = name.replace(searched, '<span style="font-weight:bold;color:black;">' + searched + '</span>')
        $('#product-list').append(view.render().el)
        $('#product-list').children().last().children('.product-title').html(bold)  

  

class Wishlist.Views.listItem extends Backbone.View
  template: JST['products/listitem']
  tagName: 'div'
  render: (data) ->
    window.listitem = @model
    $(@el).html(@template)
    this

class Wishlist.Views.saveList extends Backbone.View
  template: JST['products/saveList']
  tagName: 'span'
  el: '#saveListContainer'

  events:
    "click #save-button": "saveWishlist"

  render: (data) ->
    $(@el).html(@template)
    this

  saveWishlist: ->
    $('#search-container').slideUp()
    $('#product-list-container').slideUp()
    ($ '#saveListcontainer').slideDown()
    window.wishlist.each (model) ->
      console.log model.get('name')
      

class Wishlist.Views.Product extends Backbone.View#single item view
  template: JST['products/product']
  events: 
    "hover" : "overlay"
    "click .overlay" : "grow"
    "click #back-button" : "back"
    "click #add-button": "addItem"

  tagName: 'div'
  className: 'product'
  
  overlay: (element) ->
    $(element.currentTarget).toggleClass('hover') unless $(element.currentTarget).attr('class').match(/full-view/i)#$(element.currentTarget) is uequivalent $(this)

  addItem: (element) ->
    prodname = @model.get('name')
    console.log @model
    html = "<div class='clr'></div><div class='row'><div class='bullet'><img class='start' src='/assets/check.png'></div><div class='field'><img class=\"list-item-image\" src=\"" + @model.get('hero_img_url') + "\"><p class=\"list-item\">&nbsp;" + prodname + "<span class=\"list-item-span\">By " + @model.get('brand') + "</span></p></div></div>"
    $('#search-container').prepend html
    listheight = ($ '.wishlist').height()
    rowheight = ($ '.row').height()
    newheight = rowheight + listheight
    ($ '.wishlist').height(newheight)
    # same as back method #
    $elem = $(element.currentTarget).parent().parent().parent()
    $elem.children('.description-container').hide()
    $elem.removeClass('full-view')
    $elem.animate({width: '118px', height: '140px'}, 400)
    $elem.append('<span class="overlay"></span>')
    $elem.addClass('hover')
    $('.filters').show()
    $elem.parent().children().each ->
      $(this).fadeIn()
    #add a cookie
    key = 'products='
    for c in document.cookie.split(';')
      c.substring(1, c.length) while c.charAt(0) is ' '
      products = c.substring(key.length, c.length) if c.indexOf(key) == 0
    dt = new Date()
    expiryTime = dt.setTime(dt.getTime()+100*60*60*24*90)
    document.cookie = 'products=' + products + ',' + @model.get('id') + ';expires=' + dt.toGMTString()


  grow: (element) ->
      parent = $('#product-list')
      position = parent.children().index($(element.currentTarget).parent())
      parent.children().each ->
        if $(this).index() isnt position
          $(this).hide()
        if $(this).index() is position
          $('.filters').hide()
          $(this).removeClass('hover')
          $(this).addClass('full-view')
          $(this).animate({width: '540px', height: '492px'}, 400)
          $(this).children('.overlay').remove()
          $(this).children('.description-container').show()
          $(this).attr('id', 'open')

        
  back: (element) ->
    $elem = $(element.currentTarget).parent().parent()
    $elem.children('.description-container').hide()
    $elem.removeClass('full-view')
    $elem.animate({width: '118px', height: '140px'}, 400)
    $elem.append('<span class="overlay"></span>')
    $elem.addClass('hover')
    $('.filters').show()
    $elem.parent().children().each ->
      $(this).fadeIn()


  render: (data) ->#needs a MODEL passed to it!
    window.product = @model#make product variable available on global scope
    $(@el).html(@template)
    this




