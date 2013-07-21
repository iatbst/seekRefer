class CreateConnectRequests < ActiveRecord::Migration
  def change
    create_table :connect_requests do |t|
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
