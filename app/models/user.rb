class User < ActiveRecord::Base

  before_create :create_remember_token
  before_save :normalize_fields

  #Validates name:
  validates :name,
    presence: true,
    length: {maximum: 50}

  #Validates emails:
  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: { with: /[^a]+@[^a]+/ }

  #validates password length
  validates :password,
    length: { minimum: 8 }

  #Create a new remember token for the user:
  def self.new_remember_token
    SecureRandom.urlsafe_base64 #SecureRandom is a module in ruby
  end


  # Secure password features:
  has_secure_password

  def self.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  #Creates a new sessions token for the user
  def create_remember_token
    remember_token = User.hash(User.new_remember_token)
  end

  #Normalize fields for consistancy
  def normalize_fields
    self.email.downcase!
  end


end
