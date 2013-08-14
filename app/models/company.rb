class Company < ActiveRecord::Base
  require "open-uri"
  
  #Association
  has_many :users
  has_many :locations, :through => :users
  belongs_to :industry
  
  #Paperclip
  has_attached_file :logo, :styles => { :medium => "900x300>", 
                                          :small => "300x100>", 
                                          :thumb => "150x50>" }, 
                              :default_url => "/images/companies/defaultLogo_:style.jpg"

  def logo_from_url(url)
    self.logo = URI.parse(url)
  end
end
