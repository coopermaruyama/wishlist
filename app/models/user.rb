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
      password = Devise.friendly_token[0,20]
      user = User.create(first_name: auth.info.first_name,
                        last_name: auth.info.last_name,
                        provider: auth.provider,
                        uid: auth.uid,
                        email: auth.info.email,
                        password: password,
                        password_confirmation: password)
    end
    user
end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data["first_name"] if user.first_name.blank?
        user.last_name = data["last_name"] if user.last_name.blank?
      end
    end
  end

  def password_required?
    super && provider.blank?
  end
end
