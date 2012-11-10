class PaymentNotification < ActiveRecord::Base
	belongs_to :list
	serialize :params
	after_create :add_donation_to_wishlist
	after_create :check_if_item_bought
	attr_accessible :params, :list_id, :status, :transaction_id, :amount

	private

	def add_donation_to_wishlist
		if status == "Completed"
			list.update_attribute(:balance, list.balance + self.amount.to_i)
			list.challengeBalance #Check if enough has been donated to purchase an item.
		end
	end

	def check_if_item_bought
		#TODO
		unless self.item_number.blank?
			list.line_items.find_by_product_id(self.item_number).destroy
		# buy_item_from_amazon(self.item_number)
		end 
	end
end
