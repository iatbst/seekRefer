class CreateReferCases < ActiveRecord::Migration
  def change
    create_table :refer_cases do |t|
      t.string :referrer
      t.string :referral
      t.string :status

      t.timestamps
    end
  end
end
