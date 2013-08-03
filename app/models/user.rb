class User < ActiveRecord::Base
  # Model Associations 
  has_many :referrer_cases, class_name: "ReferCase", foreign_key: "referrer_id" 
  has_many :referral_cases, class_name: "ReferCase", foreign_key: "referral_id" 
  belongs_to :company
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  #Paperclip
  has_attached_file :avatar, :styles => { :medium => "150x150>", 
                                          :small => "100x100>", 
                                          :thumb => "50x50>" }, 
                              :default_url => "/images/users/defaultAvatar_:style.png"
    
end