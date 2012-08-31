class FBShare
	@queue = :fb_queue
	def self.perform(user_id, share_link)
		User.share_list(user_id, share_link)
	end
end