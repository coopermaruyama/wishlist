class SavelistController < ApplicationController
	def index
		@user = current_user
		@list = @user.list
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
	    begin
			@share_list = User.delay.share_list(current_user, "http://#{request.host}/lists/#{@list.id}")
		rescue
			#Rails.logger.error "Share list error: #{e}"
		end
	end
end
