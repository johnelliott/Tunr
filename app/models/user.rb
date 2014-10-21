class User < ActiveRecord::Base
  # Validates name:
  valdates :name,
    presence: true,
    length: {maximum: 50}

  # Validates email:
  valdates :email,
    presence: true,
    unique: {case_sensitive: false},
    format: {with: /[^@]+@[^@]/ }

  # Validates password:
  valdates :password,
    length: {minimum: 8}

  # Secure password features
  has_secure_password

  # create new rember token for the user
  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def self.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

private
  
  # Create a new session token for the user
  def create_remember_token
    remember_token = self.hash(self.new_remember_token)
  end

  def normalize_fields
    self.email.downcase!
  end
end