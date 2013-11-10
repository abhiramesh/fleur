class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :image, :location, :authentication_token, :points

  has_many :authorizations, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :items, through: :votes
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships

  
  before_save :ensure_authentication_token
 
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(self.authorizations.find_by_provider("facebook").first.oauth_token)
  end

  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
    action = Action.create(:title => "follow", :user_id => self.id)
      other_user.points = other_user.points.to_i + 1
      other_user.save!
  end

  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user).destroy!
  end
 
  private
  
  def generate_authentication_token
    loop do
      token = SecureRandom.hex
      break token unless User.where(authentication_token: token).first
    end
  end

end
