# Load the rails application
require File.expand_path('../application', __FILE__)

redis = Redis.connect :url => ENV["OPENREDIS_URL"]

# Initialize the rails application
Wishlist::Application.initialize!
