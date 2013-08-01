class RemodelConnections < ActiveRecord::Migration
  def change
    remove_column :connects, :from
    remove_column :connects, :to
    add_reference :connects, :from, index: true
    add_reference :connects, :to, index: true
  end
end
