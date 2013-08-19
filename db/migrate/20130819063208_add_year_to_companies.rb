class AddYearToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :founded_year, :string
  end
end
