class FollowRule < ActiveRecord::Base
  belongs_to :company
  belongs_to :location
  belongs_to :industry
end
