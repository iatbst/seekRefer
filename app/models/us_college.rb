class UsCollege < ActiveRecord::Base
  has_many :users1, class_name: "User", foreign_key: "us_school1_id"
  has_many :users2, class_name: "User", foreign_key: "us_school2_id" 
end
