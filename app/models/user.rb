class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  #Paperclip
  has_attached_file :avatar, :styles => { :medium => "150x150>", 
                                          :small => "100x100>", 
                                          :thumb => "50x50>" }, 
                              :default_url => "/images/users/defaultAvatar_:style.png"
    
end