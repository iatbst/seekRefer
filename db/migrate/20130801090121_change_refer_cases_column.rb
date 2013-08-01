class ChangeReferCasesColumn < ActiveRecord::Migration
  def change
    remove_column :refer_cases, :referrer_id
    remove_column :refer_cases, :referral_id
  end
end
