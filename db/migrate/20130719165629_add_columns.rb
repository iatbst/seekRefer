class AddColumns < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :company, :string
    add_column :users, :dept, :string
    add_column :users, :position, :string 
  end
end
