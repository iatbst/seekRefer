class ChangeUsersColumn < ActiveRecord::Migration
  def change
    rename_column :users, :company, :company_name
  end
end
