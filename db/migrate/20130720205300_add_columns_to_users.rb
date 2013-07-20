class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hometown, :string
    add_column :users, :china_school1, :string
    add_column :users, :china_school2, :string
    add_column :users, :us_school1, :string
    add_column :users, :us_school2, :string
  end
end
