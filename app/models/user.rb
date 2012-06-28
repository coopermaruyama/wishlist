class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :provider, :uid
  # attr_accessible :title, :body

  validates :first_name, presence: true, length: {within: 2..25}
  validates :last_name, presence: true, length: {within: 2..30}

  has_one :list

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(first_name: auth.extra.raw_info.name,
                        provider: auth.provider,
                        uid: auth.uid,
                        email: auth.info.email,
                        password: Devise.friendly_token[0,20])
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
