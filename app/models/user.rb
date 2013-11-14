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

  require 'mechanize'
 
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(self.authorizations.find_by_provider("facebook").first.oauth_token)
  end

  def get_profile_image
    graph = Koala::Facebook::API.new(self.authorizations.find_by_provider("facebook").first.oauth_token)
    if graph
      g = graph.fql_query("SELECT url FROM square_profile_pic WHERE id = me() AND size=200")
      g = JSON.parse(g.to_json)
      image = g[0]["url"]
      self.image = image
      self.save!
    end
  end

  def send_user_to_predict
    url = "http://ec2-23-22-86-95.compute-1.amazonaws.com:8000/users.json"
    params = {
      "pio_appkey" => "UKG01Nnn6pjEk4WZ7oBO2dlwISHMBupxam13yrUbB8xVqCWsFXkaVxefooGslVYA",
      "pio_uid" => self.id.to_s
    }
    puts response.content
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
