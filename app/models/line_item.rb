class LineItem < ActiveRecord::Base
  attr_accessible :list_id, :product_id
  belongs_to :product
  belongs_to :list
end
