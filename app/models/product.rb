class Product < ActiveRecord::Base
  attr_accessible :brand, :description, :name, :price

  PRICE_REGEX = /[0-9]+\.[0-9]{2}/

  validates :name, presence: true, length: {within: 2..80}
  validates :price, presence: true, format: {with: PRICE_REGEX}, numericality: {greater_than: 0}
  validates :description, length: {maximum: 5000}
end
