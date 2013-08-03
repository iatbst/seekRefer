class FixCompany < ActiveRecord::Migration
  def change
    remove_column :users, :company
    add_reference :users, :company, index: true
  end
end
