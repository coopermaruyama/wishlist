class List < ActiveRecord::Base
  attr_accessible :category, :name, :user_id
  # belongs_to :user
  has_many :line_items
end
