class Product < ActiveRecord::Base
  # TODO source should not be mass-assigned
  attr_accessible :brand, :description, :name, :price, :hero_img_url, :source

  PRICE_REGEX = /^[0-9]{1,9}\.[0-9]{2}$/
  SOURCE_REGEX= /^external$|^internal$/

  validates :name, presence: true, length: {within: 2..80}
  validates :price, presence: true, format: {with: PRICE_REGEX}, numericality: {greater_than: 0}
  validates :description, length: {maximum: 5000}
  validates :source, presence: true, format: {with: SOURCE_REGEX}
end
