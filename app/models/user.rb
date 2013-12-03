class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_save { self.username = username.downcase }
	validates :first_name, presence: true, length: { maximum: 10 }
	validates :last_name, presence: true, length: { maximum: 20 }
	validates :username, presence: true, length: { minimum: 6 }, uniqueness: { case_sensitive: false } 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }
end
