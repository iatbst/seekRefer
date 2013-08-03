class Company < ActiveRecord::Base
  #Association
  has_many :users
  has_many :locations, :through => :users
  
  #Paperclip
  has_attached_file :logo, :styles => { :medium => "900x300>", 
                                          :small => "300x100>", 
                                          :thumb => "150x50>" }, 
                              :default_url => "/images/companies/defaultLogo_:style.jpg"
end
