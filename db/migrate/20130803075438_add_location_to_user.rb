class AddLocationToUser < ActiveRecord::Migration
  def change
    add_reference :users, :location, index: true
  end
end
