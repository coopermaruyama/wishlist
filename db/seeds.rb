# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

require 'factory_girl'
require_relative '../spec/factories/factories.rb'

(1..20).each {FactoryGirl.create(:user)}

(1..50).each do |i|
  price = "#{i}9.99"
  FactoryGirl.create(:product, price: price)
end
