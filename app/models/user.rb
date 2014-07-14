require 'soundcloud'
class User < ActiveRecord::Base
  has_many :bands
  belongs_to :school

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  uniqueness: { case_sensitive: false } 

  has_secure_password
  validates :password, length: { minimum: 6 }

  # # DEVELOPMENT
  SOUNDCLOUD_CLIENT_ID = "45ca7c7c9b41fdcb2501bb7dd27e168b"
  SOUNDCLOUD_CLIENT_SECRET = "5d4d32e075ed373da82d3a454153e9e4"

  def User.soundcloud_client
    client = Soundcloud.new(:client_id => SOUNDCLOUD_CLIENT_ID,
    :client_secret => SOUNDCLOUD_CLIENT_SECRET, 
    :redirect_uri => "http://localhost:3000/connected")
  end

  def User.get_soundcloud_client_id
    SOUNDCLOUD_CLIENT_ID
  end

  def User.get_soundcloud_client(user)
    if user.soundcloud_access_token?
      User.access_soundcloud_client(user.soundcloud_access_token)
    else
      nil
    end
  end

  def User.access_soundcloud_client(access_token)
  client = Soundcloud.new(:access_token => access_token)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end

end
