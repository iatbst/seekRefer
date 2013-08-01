class AddRefToReferCases < ActiveRecord::Migration
  def change
    add_reference :refer_cases, :referrer, index: true
    add_reference :refer_cases, :referral, index: true
  end
end
