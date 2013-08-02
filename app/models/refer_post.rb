class ReferPost < ActiveRecord::Base
  belongs_to :refer_case
  belongs_to :user
end
