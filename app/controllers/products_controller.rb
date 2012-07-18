class ProductsController < ApplicationController
  respond_to :json
  
  def index
    @products = Amazon::Ecs.item_search(params[:q], response_group: 'Medium').items.map do |item|
      OpenStruct.new(
        name: item.get('ItemAttributes/Title'),
        price: item.get('ItemAttributes/ListPrice/Amount').to_i / 100.0,
        description: HTMLEntities.new.decode(item.get('EditorialReviews/EditorialReview/Content')),
        brand: item.get('ItemAttributes/Manufacturer'),
        hero_img_url: item.get('SmallImage/URL'),
      )
    end

    respond_with @products
  end
  
  def show
    respond_with Product.find(params[:id])
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
