class PaymentNotification < ActiveRecord::Base
	belongs_to :list
	serialize :params
	after_create :add_donation_to_wishlist
	attr_accessible :params, :list_id, :status, :transaction_id, :amount

	private

	def add_donation_to_wishlist
		if status == "Completed"
			list.update_attribute(:balance, list.balance + self.amount.to_i)
		end
	end
end
