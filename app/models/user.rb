class User < ActiveRecord::Base
  before_save do
     self.email = email.downcase 
     self.name = name.downcase
  end
  
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
end