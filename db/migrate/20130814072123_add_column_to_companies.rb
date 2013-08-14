class AddColumnToCompanies < ActiveRecord::Migration
  def change
    add_reference :companies, :industry, index: true
    add_column :companies, :logo_url, :string
    add_column :companies, :employee_count_range, :string
  end
end
