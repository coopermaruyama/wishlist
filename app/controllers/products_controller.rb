class ProductsController < ApplicationController
  respond_to :json
  
  def index
    if params[:ids]
      @result = Amazon::Ecs.item_lookup(params[:ids].join(','), response_group: 'Medium')
    elsif params[:q] and not params[:i]
      @result = Amazon::Ecs.item_search(params[:q], response_group: 'Medium', search_index: 'All', :item_page =>"1")
    elsif params[:q] and params[:i]
      @result = Amazon::Ecs.item_search(params[:q], response_group: 'Medium', search_index: 'All', :item_page => params[:i])
    end
    @products = @result.items.map do |item|
      OpenStruct.new(
        id: item.get('ASIN'),
        name: item.get('ItemAttributes/Title'),
        price: (item.get('ItemAttributes/ListPrice/Amount').to_i.presence || item.get('OfferSummary/LowestNewPrice/Amount').to_i)  / 100.0,
        description: HTMLEntities.new.decode(item.get('EditorialReviews/EditorialReview/Content')),
        brand: item.get('ItemAttributes/Manufacturer'),
        hero_img_url: item.get('SmallImage/URL'),
      )
    end

    respond_with @products
  end
  
  def show
    @result = Amazon::Ecs.item_lookup(params[:id], response_group: 'Large')

    @product = OpenStruct.new(
        id: @result.items.first.get('ASIN'),
        name: @result.items.first.get('ItemAttributes/Title'),
        price: (@result.items.first.get('ItemAttributes/ListPrice/Amount').to_i.presence || @result.items.first.get('OfferSummary/LowestNewPrice/Amount').to_i)  / 100.0,
        description: HTMLEntities.new.decode(@result.items.first.get('EditorialReviews/EditorialReview/Content')),
        brand: @result.items.first.get('ItemAttributes/Manufacturer'),
        hero_img_url: @result.items.first.get('LargeImage/URL'),
        reviews: @result.items.first.get('CustomerReviews/IFrameURL').gsub("&amp;", "&")
      )
    respond_with @product
  end
  
  def create
    respond_with Product.create(params[:product])
  end
  
  def update
    respond_with Product.update(params[:id], params[:product])
  end
  
  def destroy
    respond_with Product.destroy(params[:id])
  end
end
