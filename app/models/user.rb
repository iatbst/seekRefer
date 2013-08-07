class User < ActiveRecord::Base
  # Model Associations 
  has_many :connects, foreign_key: "from_id"
  has_many :connect_users, :source => :to, class_name: "User", :through => :connects
  has_many :referrer_cases, class_name: "ReferCase", foreign_key: "referrer_id" 
  has_many :referral_cases, class_name: "ReferCase", foreign_key: "referral_id" 
  belongs_to :company
  belongs_to :location
  belongs_to :hometown, class_name: "ChinaCity"
  belongs_to :china_school1, class_name: "ChinaCollege", foreign_key: "china_school1_id"
  belongs_to :china_school2, class_name: "ChinaCollege", foreign_key: "china_school2_id"
  belongs_to :us_school1, class_name: "UsCollege", foreign_key: "us_school1_id"
  belongs_to :us_school2, class_name: "UsCollege", foreign_key: "us_school2_id"
  
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