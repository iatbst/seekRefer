class AddColumnToConnectRequest < ActiveRecord::Migration
  def change
    add_column :connect_requests, :token, :string
  end
end
