class RemodelReferRequests < ActiveRecord::Migration
  def change
    remove_column :refer_requests, :from
    remove_column :refer_requests, :to
    add_reference :refer_requests, :from, index: true
    add_reference :refer_requests, :to, index: true
  end
end
