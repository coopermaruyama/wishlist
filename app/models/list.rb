class List < ActiveRecord::Base
  attr_accessible :category, :name, :user_id
  belongs_to :user
end
