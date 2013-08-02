class ReferCase < ActiveRecord::Base
  belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"
  belongs_to :referral, :class_name => "User", :foreign_key => "referral_id"
  has_many :refer_posts
end
