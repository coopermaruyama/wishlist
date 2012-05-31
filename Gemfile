source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'devise'
gem 'cancan'
gem 'heroku'
gem 'thin'
gem 'jquery-rails' # Let's consider using google CDN
gem 'haml'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
#     gem "coffee-rails
#       gem "uglifier
#         gem "less"
#           gem "less-rails-bootstrap"
#             # Asset sync for production to offload asset loading to s3
#               gem "asset_sync"
#               end"
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'less'
  gem 'less-rails-bootstrap'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'simplecov'
  gem 'factory_girl_rails'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'spork-rails'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'guard-cucumber'
  gem 'sqlite3'
end

group :test, :development do
  gem 'debugger'
  gem 'rspec-rails'
  gem 'factory_girl' # used to load factories in db/seeds
end

group :development do
  gem 'sqlite3'
  gem 'haml-rails'
  gem 'faker'
end

group :production do
  gem 'pg'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

