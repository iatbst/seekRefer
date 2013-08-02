class CreateReferRequests < ActiveRecord::Migration
  def change
    create_table :refer_requests do |t|
      t.string :from
      t.string :to
      t.string :token
      t.boolean :accepted

      t.timestamps
    end
  end
end
