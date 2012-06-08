class Product < ActiveRecord::Base
  attr_accessible :brand, :description, :name, :price
end
