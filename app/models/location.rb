class Location < ActiveRecord::Base
  has_many :users
  has_many :companies, :through => :users, :uniq => true 
end
