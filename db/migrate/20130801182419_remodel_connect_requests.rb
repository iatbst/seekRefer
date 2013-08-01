class RemodelConnectRequests < ActiveRecord::Migration
  def change
    remove_column :connect_requests, :from
    remove_column :connect_requests, :to
    add_reference :connect_requests, :from, index: true
    add_reference :connect_requests, :to, index: true
  end
end
