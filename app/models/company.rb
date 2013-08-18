class Company < ActiveRecord::Base
  require "open-uri"
  
  #Association
  has_many :users
  has_many :locations, :through => :users
  belongs_to :industry
  
  #Paperclip
  has_attached_file :logo, :styles => { :medium => "300x300>", 
                                          :small => "120x120>", 
                                          :thumb => "60x60>" }, 
                              :default_url => "/images/companies/defaultLogo_:style.jpg"

  def logo_from_url(url)
    self.logo = URI.parse(url)
  end
end
