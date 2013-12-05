class User < ActiveRecord::Base
  has_many :posts
	has_secure_password
  before_save { email.downcase! }
	before_save { username.downcase! }
	before_create :create_remember_token
	validates :first_name, presence: true, length: { maximum: 10 }
	validates :last_name, presence: true, length: { maximum: 20 }
	validates :username, presence: true, length: { minimum: 6 }, uniqueness: { case_sensitive: false } 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
