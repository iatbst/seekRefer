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
  
  # before save user to database, check company if exist in company database
  before_save :verify_company
  
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
                              
                              
  def verify_company
    if self.company_id.nil? && !self.company_name.nil?
      #create new company item 
      company = Company.new(name:self.company_name)
      company.save
      self.company_id = company.id
      
    elsif !self.company_id.nil?
      #set is_active field for this company, which means some users belongs to this company
      company = Company.find(self.company_id)
      if company.is_active == false
        company.is_active = true
        company.save
      end
      
    end
    
  end
    
    
end