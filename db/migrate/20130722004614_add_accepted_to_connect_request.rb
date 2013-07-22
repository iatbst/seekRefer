class AddAcceptedToConnectRequest < ActiveRecord::Migration
  def change
    add_column :connect_requests, :accepted, :bool
  end
end
