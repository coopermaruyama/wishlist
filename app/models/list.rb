class List < ActiveRecord::Base
  attr_accessible :category, :name, :user_id, :balance, :full_name, :address1, :address2, :city, :state, :zip_code, :phone_number
  belongs_to :user
  has_many :line_items

  def challengeBalance
  	eligible = []
  	self.line_items.each do |item|
  		result = Amazon::Ecs.item_lookup(item.product_id, response_group: 'Medium').items.first
  		puts result
  		price = (result.get('ItemAttributes/ListPrice/Amount').to_i.presence || result.get('OfferSummary/LowestNewPrice/Amount').to_i) / 100.0
  		if self.balance > price
  			eligible << item.product_id
  		end
  	end
  	if eligible.present?
  		return eligible
  	else
  		return false
  	end
  end
end
