class AddColumnsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :is_active, :boolean
    add_column :companies, :is_verified, :boolean
  end
end
