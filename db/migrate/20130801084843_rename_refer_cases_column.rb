class RenameReferCasesColumn < ActiveRecord::Migration
  def change
    rename_column :refer_cases, :referrer, :referrer_id
    rename_column :refer_cases, :referral, :referral_id 
  end
end
