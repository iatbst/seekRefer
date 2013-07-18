class User < ActiveRecord::Base
  before_save do
     self.email = email.downcase 
     self.name = name.downcase
     :create_remember_token
  end
  #before_create :create_remember_token
  
  #belongs_to :company
  #validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: 10, minimum: 5}, uniqueness: {case_sensitive: false}
  validates :company, presence: true
  validates :dept, presence: true
  validates :position, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  
  #password 
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