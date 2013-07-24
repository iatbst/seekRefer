class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :omniauthable
 
  #Paperclip
  has_attached_file :avatar, :styles => { :medium => "300x300>", :small => "100x100>", :thumb => "50x50>" }
    
end