class ListsController < ApplicationController
  respond_to :json
  def index
  end

  def show
    @is_list = true
    @list = List.find(params[:id])
    @user = User.find(@list.user_id)
    @line_items = @list.line_items
    @ids = Array.new
    @line_items.each do |item|
      @ids.push(item.product_id)
    end
    
    @result = Amazon::Ecs.item_lookup(@ids.join(','), response_group: 'Medium')


    @products = @result.items.map do |item|
        OpenStruct.new(
          id: item.get('ASIN'),
          name: item.get('ItemAttributes/Title'),
          price: item.get('ItemAttributes/ListPrice/Amount').to_i / 100.0,
          description: HTMLEntities.new.decode(item.get('EditorialReviews/EditorialReview/Content')),
          brand: item.get('ItemAttributes/Manufacturer'),
          hero_img_url: item.get('MediumImage/URL'),
        )
      end

    @share_link = Resque.enqueue(FBShare, current_user.id, "#{request.protocol}#{request.host_with_port}#{request.fullpath}")
    
  end

  def new
    @list = current_user.build_list
  end

  def create
    @list = current_user.build_list(params[:list])
    @list.save
    # if @list.save
    #   format.json { render json:  @list, status: :created }
    # else
    #   format.json { render json: @list.errors, status: :unprocessable_entity}
    # end
  end

  def edit
    @list = List.find(params[:list])
  end

  def update
    @list = List.find(params[:list])
    if @list.update_attributes params[:list]
      format.json { head :no_content }
    else
      format.json { render json @list.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    # TODO cookie support
  end

end
