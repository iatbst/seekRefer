class FixHometownReference < ActiveRecord::Migration
  def change
    remove_column :users, :hometown
    add_reference :users, :hometown, index: true
  end
end
