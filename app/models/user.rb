class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates :first_name, presence: true, length: {within: 2..25}
  validates :last_name, presence: true, length: {within: 2..30}

  # has_one :list
end
