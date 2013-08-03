class ChinaSchoolReference < ActiveRecord::Migration
  def change
    remove_column :users, :china_school1
    remove_column :users, :china_school2
    add_reference :users, :china_school1, index: true
    add_reference :users, :china_school2, index: true
  end
end
