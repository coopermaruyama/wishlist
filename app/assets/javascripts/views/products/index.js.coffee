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
        searched = $('.input-search').val()
        name = product.get('name')
        bold = name.replace(searched, '<span style="font-weight:bold;color:black;">' + searched + '</span>')
        $('#product-list').append(view.render().el)
        $('#product-list').children().last().children('.product-title').html(bold)
    
class Wishlist.Views.Product extends Backbone.View#single item view
  template: JST['products/product']
  events: 
    "hover" : "overlay"
    "click .overlay" : "grow"
    "click #back-button" : "back"
  tagName: 'div'
  className: 'product'
  
  overlay: (element) ->
    $(element.currentTarget).toggleClass('hover') unless $(element.currentTarget).attr('class').match(/full-view/i)#$(element.currentTarget) is uequivalent $(this)
    
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




