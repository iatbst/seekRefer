class UsSchoolReference < ActiveRecord::Migration
  def change
    remove_column :users, :us_school1
    remove_column :users, :us_school2
    add_reference :users, :us_school1, index: true
    add_reference :users, :us_school2, index: true
  end
end
