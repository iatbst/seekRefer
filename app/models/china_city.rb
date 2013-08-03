class ChinaCity < ActiveRecord::Base
  has_many :users, foreign_key: "hometown_id"
end
