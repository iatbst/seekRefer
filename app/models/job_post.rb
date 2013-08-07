class JobPost < ActiveRecord::Base
  belongs_to :industry
  belongs_to :company
  belongs_to :location
  belongs_to :poster, class_name: "User"
end
